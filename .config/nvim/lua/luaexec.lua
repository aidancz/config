local M = {}

-- # data

M.mode_registry = {
--[[
	mode1 = {
		node1 = {
			code = ...,
			from = "mode1",
			name = "node1",
			desc = ...,
			lkey = ...,
			gkey = ...,
		},
		node2 = {
			...
		},
		...
		<metatable> = {
			__index = {
				name = "mode1",
			},
		},
	},
	mode2 = {
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

M.current_mode = nil

-- # function

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
	cmd_tbl_inspect = string.sub(cmd, 1+25, -(1+8))

	local f = load("return " .. cmd_tbl_inspect)
	if not f then return end
	cmd_tbl = f()

	code_tbl = cmd_tbl
	table.remove(code_tbl, 1)
	table.remove(code_tbl)

	return code_tbl
end

M.exec = function(code_str, histadd)
	if histadd == nil then
		histadd = true
	end

	local code_tbl = vim.split(code_str, "\n", {trimempty = true})

	local cmd = M.code2cmd(code_tbl)
	if histadd then
		vim.fn.histadd("cmd", cmd)
	end
	vim.cmd(cmd)
end

M.node_set_key = function(node, prefix)
	for _, i in pairs(vim.tbl_keys(node)) do
		if string.match(i, "^" .. prefix) then
			vim.keymap.set(
				node[i][1],
				node[i][2],
				function()
					M.exec(node.code, false)
				end,
				node[i][3] or {}
			)
		end
	end
end

M.mode_set_key = function(mode, prefix)
	for _, i in pairs(mode) do
		M.node_set_key(i, prefix)
	end
end

M.add = function(node)
	-- for k, v in pairs(node) do
	-- 	if vim.is_callable(v) then
	-- 		node[k] = v()
	-- 	end
	-- end

	node = vim.tbl_deep_extend(
		"force",
		{
			from = "default",
		},
		node
	)

	M.node_set_key(node, "gkey")

	if M.mode_registry[node.from] == nil then
		M.mode_registry[node.from] = setmetatable(
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
		table.insert(M.mode_registry[node.from], node)
	else
		M.mode_registry[node.from][node.name] = node
	end
end

M.set_current_mode = function(mode_name)
	M.current_mode = M.mode_registry[mode_name]
	M.mode_set_key(M.current_mode, "lkey")
	vim.schedule(function()
		vim.cmd("redrawstatus")
	end)
end

M.get_current_mode = function()
	return M.current_mode
end

M.list_mode_names = function()
	return
	vim.tbl_keys(M.mode_registry)
end

M.list_nodes = function()
	local nodes

	nodes = vim.deepcopy(vim.tbl_values(M.current_mode))

	for mode_name, mode in pairs(M.mode_registry) do
		if mode_name == M.current_mode.name then goto continue end
		vim.list_extend(nodes, vim.tbl_values(mode))
		::continue::
	end

	return nodes
end

-- # return

return M
