local M = {}

-- # data

M.mode_list = {
}

M.current_mode = nil

-- # function

M.add_mode = function(mode)
	table.insert(M.mode_list, mode)
end

M.get_mode = function(name)
	for _, i in ipairs(M.mode_list) do
		if i.name == name then
			return i
		end
	end
end

M.list_names = function()
	local names = {}
	for _, i in ipairs(M.mode_list) do
		table.insert(names, i.name)
	end
	return names
end

M.set_current_mode = function(name)
	M.current_mode = M.get_mode(name)
	M.current_mode:setup()
	vim.schedule(function()
		vim.cmd("redrawstatus")
	end)
end

M.get_current_mode = function()
	return M.current_mode
end

-- # return

return M
