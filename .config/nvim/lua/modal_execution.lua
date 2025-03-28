local M = {}
local H = {}

-- # config & setup

M.config = {
	mode_list = nil,
	default_mode = nil,
}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
	M.set_current_mode(M.config.default_mode)
end

-- # data

M.mode = nil

-- # cache

M.cache = {
}

-- # function

M.list_names = function()
	local names = {}
	for _, i in ipairs(M.config.mode_list) do
		table.insert(names, i.name)
	end
	return names
end

M.get_mode = function(name)
	for _, i in ipairs(M.config.mode_list) do
		if i.name == name then
			return i
		end
	end
end

M.get_current_mode = function()
	return M.mode
end

M.set_current_mode = function(name)
	M.mode = M.get_mode(name)
	M.mode:setup()
end

-- # return

return M
