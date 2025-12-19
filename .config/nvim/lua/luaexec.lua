local M = {}

-- # data

M.registry = {
--[[
	group1 = {
		node1 = {
			code = ...,
			from = "group1",
			name = "node1",
			desc = ...,
			keys = ...,
			<metatable> = {
				__call = M.node_exec,
			},
		},
		node2 = {
			...
		},
		...
		<metatable> = {
			__index = {
				name = "group1",
			},
		},
	},
	group2 = {
		node1 = {
			...
		},
		node2 = {
			...
		},
		...
		<metatable> = {
			...
		},
	},
	...
--]]
}

-- # core

--[=[
chunk:
	{
		[[print_time()]],
		[[return "5j"]],
	}

temp:
	[[{ "print_time()", 'return "5j"' }]]

excmd:
	[[lua require("luaexec").load({ "print_time()", 'return "5j"' })]]
--]=]

M.remap = false

M.remap_temp = function()
	M.remap = true
	vim.schedule(function()
		M.remap = false
	end)
end

M.is_operator_pending_mode = function()
	local mode = vim.api.nvim_get_mode().mode
	return string.sub(mode, 1, 2) == "no"
end

M.feedkeys = function(keys, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, false)
end

M.load = function(chunk)
	local str = table.concat(chunk, "\n")
	local ret = assert(load(str))()
	if ret == nil then return end

	local key
	local cnt = tostring(vim.v.count)
	if cnt == "0" then cnt = "" end
	if not M.is_operator_pending_mode() then
		key = cnt .. ret
	else
		local reg = [["]] .. vim.v.register
		local ope = vim.v.operator
		key = reg .. ope .. cnt .. ret
	end

	local mod = M.remap and "m" or "n"

	M.feedkeys(key, mod)
end

M.chunk2excmd = function(chunk)
	local temp = vim.inspect(chunk)
	-- temp does not contain "\n", since "array-like" tables are rendered horizontally
	-- https://github.com/kikito/inspect.lua

	local excmd = [[lua require("luaexec").load(]] .. temp .. [[)]]

	return excmd
end

M.excmd2chunk = function(excmd)
	if string.sub(excmd, 1, 28) ~= [[lua require("luaexec").load(]] then return end
	local temp = string.sub(excmd, 29, -2)

	local f = load("return " .. temp)
	if not f then return end
	local chunk = f()

	return chunk
end

---@param opts? {
---	run?: boolean|true,
---	histadd?: boolean|false,
---}
M.exec = function(chunk, opts)
	opts = vim.tbl_extend(
		"force",
		{
			run = true,
			histadd = false,
		},
		opts or {}
	)

	local excmd = M.chunk2excmd(chunk)

	if opts.histadd then
		vim.fn.histadd("cmd", excmd)
	end
	if opts.run then
		vim.cmd(excmd)
	end
end

M.list_history = function()
	local history = {}
	for i = vim.fn.histnr(":"), 1, -1 do
		local entry = vim.fn.histget(":", i)
		if entry == "" then goto continue end
		local chunk = require("luaexec").excmd2chunk(entry)
		if chunk == nil then goto continue end

		table.insert(
			history,
			{
				histnr = i,
				chunk = chunk,
			}
		)

		::continue::
	end
	return history
end

-- # nextprev (np)

M.np_update0 = function()
	M.np_is_repeat = false

	M.np_group = M.registry.search
	M.np_searchnr = vim.fn.histnr("/")
end

M.np_update1 = function(node)
	if
		node.name == "next"
		or
		node.name == "prev"
	then
		M.np_group = M.registry[node.from]
		M.np_searchnr = vim.fn.histnr("/")
	end
end

M.np_update2 = function()
	local searchnr = vim.fn.histnr("/")
	if M.np_searchnr ~= searchnr then
		M.np_group = M.registry.search
		M.np_searchnr = searchnr
	end
end

M.np_node_exec = function(node)
	if node == nil then return end

	M.np_is_repeat = true
	pcall(function() node() end)
	M.np_is_repeat = false
end

-- # api

M.node_exec = function(node, opts)
	M.np_update1(node)
	local chunk = vim.split(node.code, "\n", {trimempty = true})
	M.exec(chunk, opts)
end

M.is_list_of_list = function(tbl)
	if not vim.islist(tbl) then
		return false
	end
	for _, i in ipairs(tbl) do
		if not vim.islist(i) then
			return false
		end
	end
	return true
end

M.node_set_keys = function(node)
	if node.keys == nil then return end

	local keys
	if M.is_list_of_list(node.keys) then
		keys = node.keys
	else
		keys = {node.keys}
	end

	for _, i in ipairs(keys) do
		vim.keymap.set(
			i[1],
			i[2],
			function() M.registry[node.from][node.name]() end,
			-- string.format(
			-- 	[[<cmd>lua require("luaexec").registry[%s][%s]()<cr>]],
			-- 	vim.inspect(node.from),
			-- 	vim.inspect(node.name)
			-- ),
			{}
		)
	end
end

M.node_template = {
	code = nil, -- must be provided
	from = "default",
	name = nil, -- if no value is provided, a sequential number will be used
	desc = "",
	keys = {},
}

M.node_metatable = {
	__call = M.node_exec,
}

M.add = function(node)
	-- complete and register node

	node = vim.tbl_deep_extend("force", M.node_template, node)
	setmetatable(node, M.node_metatable)

	if M.registry[node.from] == nil then
		M.registry[node.from] = setmetatable(
			{
			},
			{
				__index = {
					name = node.from
				},
			}
		)
	end
	if node.name == nil then
		node.name = #M.registry[node.from] + 1
		-- the length operator here only count "sequence length"
	end
	M.registry[node.from][node.name] = node

	-- set keys

	M.node_set_keys(node)
end

M.list_nodes = function()
	local nodes = {}
	for group_name, group in pairs(M.registry) do
		for node_name, node in pairs(group) do
			table.insert(nodes, vim.deepcopy(node))
		end
	end
	return nodes
end

-- # return

return M
