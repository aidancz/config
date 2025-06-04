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

---@param code_tbl string[]
---@return string cmd
M.code2cmd = function(code_tbl)
	local cmd_tbl
	local cmd_tbl_inspect
	local cmd

	cmd_tbl = code_tbl
	table.insert(cmd_tbl, 1, "lua << EOF")
	table.insert(cmd_tbl, "EOF")

	cmd_tbl_inspect = vim.inspect(cmd_tbl):gsub("\n", " ")

	cmd =
		[[lua vim.cmd(table.concat(]]
		..
		cmd_tbl_inspect
		..
		[[, "\n"))]]

	return cmd
end

---@param cmd string
---@return string[]|nil code_tbl
M.cmd2code = function(cmd)
	local cmd_tbl_inspect
	local cmd_tbl
	local code_tbl

	if string.sub(cmd, 1, 25) ~= [[lua vim.cmd(table.concat(]] then return end
	if string.sub(cmd, -8, -1) ~= [[, "\n"))]] then return end
	cmd_tbl_inspect = string.sub(cmd, 25+1, -(8+1))

	local f = load("return " .. cmd_tbl_inspect)
	if not f then return end
	cmd_tbl = f()

	code_tbl = cmd_tbl
	table.remove(code_tbl, 1)
	table.remove(code_tbl)

	return code_tbl
end

M.exec = function(code_tbl, histadd)
	local cmd = M.code2cmd(code_tbl)
	if histadd then
		vim.fn.histadd("cmd", cmd)
	end
	vim.cmd(cmd)
end

-- # api

M.node_exec = function(node, histadd)
	if histadd == nil then
		histadd = false
	end

	local code_tbl = vim.split(node.code, "\n", {trimempty = true})
	M.exec(code_tbl, histadd)
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
			function()
				M.node_exec(node, false)
			end,
			i[3] or {}
		)
	end
end

M.node_template = {
	from = "default",
}

M.node_metatable = {
	__call = M.node_exec,
}

M.add = function(node)
	-- setup node

	node = vim.tbl_deep_extend("force", M.node_template, node)
	setmetatable(node, M.node_metatable)
	M.node_set_keys(node)

	-- register node

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
		table.insert(M.registry[node.from], node)
	else
		M.registry[node.from][node.name] = node
	end
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
