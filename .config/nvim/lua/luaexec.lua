local M = {}

-- # data

M.mode_list = {
}

M.current_mode = nil

-- # function

---@param code_tbl string[]
---@return string cmd
M.code2cmd = function(code_tbl)
	table.insert(code_tbl, 1, "lua << EOF")
	table.insert(code_tbl, "EOF")

	local code_str
	code_str = vim.inspect(code_tbl):gsub("\n", " ")

	local cmd
	cmd = [[lua vim.cmd(table.concat(]] .. code_str .. [[, "\n"))]]
	return cmd
end

---@param cmd string
---@return string[]|nil code_tbl
M.cmd2code = function(cmd)
	if string.sub(cmd, 1, 25) ~= [[lua vim.cmd(table.concat(]] then return end

	local code_str = string.sub(cmd, 1+25, -(1+8))

	local f = load("return " .. code_str)
	if not f then return end
	local code_tbl = f()
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

M.chunk_set_key = function(chunk, prefix)
	for _, i in pairs(vim.tbl_keys(chunk)) do
		if type(i) == "string" and string.match(i, "^" .. prefix) then
			vim.keymap.set(
				chunk[i][1],
				chunk[i][2],
				function()
					M.exec(chunk.code, false)
				end,
				chunk[i][3] or {}
			)
		end
	end
end

M.mode_set_key = function(mode, prefix)
	for _, i in ipairs(mode.chunks) do
		M.chunk_set_key(i, prefix)
	end
end

M.add_mode = function(mode)
	for k, v in pairs(mode) do
		if vim.is_callable(v) then
			mode[k] = v()
		end
	end
	for _, i in ipairs(mode.chunks) do
		i.from = mode.name
	end
	M.mode_set_key(mode, "gkey")

	local same_name_mode = M.get_mode(mode.name)
	if same_name_mode == nil then
		table.insert(M.mode_list, mode)
	else
		vim.list_extend(same_name_mode.chunks, mode.chunks)
	end
end

M.get_mode = function(name)
	for _, i in ipairs(M.mode_list) do
		if i.name == name then
			return i
		end
	end
end

M.set_current_mode = function(name)
	M.current_mode = M.get_mode(name)
	M.mode_set_key(M.current_mode, "lkey")
	vim.schedule(function()
		vim.cmd("redrawstatus")
	end)
end

M.get_current_mode = function()
	return M.current_mode
end

M.list_names = function()
	local names = {}
	for _, i in ipairs(M.mode_list) do
		table.insert(names, i.name)
	end
	return names
end

M.list_chunks = function()
	local chunks
	chunks = vim.deepcopy(M.current_mode.chunks)

	for _, i in ipairs(M.mode_list) do
		if i.name == M.current_mode.name then goto continue end
		for _, j in ipairs(i.chunks) do
			table.insert(chunks, vim.deepcopy(j))
		end
		::continue::
	end

	return chunks
end

-- # return

return M
