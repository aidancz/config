local M = {}

-- # data

M.mode_list = {
}

M.current_mode = nil

-- # function

M.exec = function(code)
	local lines_tbl = vim.split(code, "\n")
	table.insert(lines_tbl, 1, "lua << EOF")
	table.insert(lines_tbl, "EOF")
	local lines_str = vim.inspect(lines_tbl):gsub("\n", " ")

	local cmd
	cmd = [[lua vim.cmd(table.concat(]] .. lines_str .. [[, "\n"))]]
	-- print(cmd)
	vim.cmd(cmd)
	vim.fn.histadd("cmd", cmd)
end

M.chunk_set_key = function(chunk)
	if chunk.key == nil then return end
	vim.keymap.set(
		chunk.key[1],
		chunk.key[2],
		function()
			M.exec(chunk.code)
		end,
		chunk.key[3] or {}
	)
end

M.mode_set_key = function(mode)
	for _, i in ipairs(mode.chunks) do
		M.chunk_set_key(i)
	end
end

M.chunk_set_gkey = function(chunk)
-- gkey: global key
	if chunk.gkey == nil then return end
	vim.keymap.set(
		chunk.gkey[1],
		chunk.gkey[2],
		function()
			M.exec(chunk.code)
		end,
		chunk.gkey[3] or {}
	)
end

M.mode_set_gkey = function(mode)
	for _, i in ipairs(mode.chunks) do
		M.chunk_set_gkey(i)
	end
end

M.add_mode = function(mode)
	mode = vim.tbl_extend(
		"force",
		{
			name = "",
			chunks = {},
		},
		mode
	)
	for k, v in pairs(mode) do
		if vim.is_callable(v) then
			mode[k] = v()
		end
	end
	for _, i in ipairs(mode.chunks) do
		i.from = mode.name
	end
	M.mode_set_gkey(mode)

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
	M.mode_set_key(M.current_mode)
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
