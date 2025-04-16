local M = {}
local H = {}

-- # config & setup

M.config = {
	buf_name = "[luaeval]",
	buf_opt = {
		filetype = "lua",
	},
	win = {
		win = -1,
		split = "below",
	},
	win_enter = true,
	win_opt = {
		winfixbuf = true,
		winfixwidth = true,
		winfixheight = true,
	},
}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
	M.buf_set_true()
end

-- # cache

M.cache = {
	buf_handle = nil,
	win_handle = nil,
	origin_win_handle = nil,
}

-- # function: buffer

M.buf_is_valid = function()
	return
		M.cache.buf_handle ~= nil
		and
		vim.api.nvim_buf_is_valid(M.cache.buf_handle)
end

M.buf_set_false = function()
	if M.buf_is_valid() then
		vim.api.nvim_buf_delete(M.cache.buf_handle, {force = true})
	else
		-- do nothing
	end
end

M.buf_set_true = function()
	if M.buf_is_valid() then
		-- do nothing
	else
		M.cache.buf_handle = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(M.cache.buf_handle, M.config.buf_name)
		-- M.cache.buf_handle = vim.fn.bufadd(vim.fn.stdpath("cache") .. "/luaeval.lua")
		-- vim.fn.bufload(M.cache.buf_handle)
		for option, value in pairs(M.config.buf_opt) do
			vim.api.nvim_set_option_value(option, value, {buf = M.cache.buf_handle})
		end
		vim.keymap.set(
			{"n", "i"},
			"<c-cr>",
			function()
				vim.api.nvim_feedkeys("", "n", false)
				M.eval()
				M.close()
			end,
			{
				buffer = M.cache.buf_handle,
			}
		)
	end
end

-- # function: window

M.win_is_valid = function()
	return
		M.cache.win_handle ~= nil
		and
		vim.api.nvim_win_is_valid(M.cache.win_handle)
end

M.win_set_false = function()
	if M.win_is_valid() then
		vim.api.nvim_win_close(M.cache.win_handle, true)
	else
		-- do nothing
	end
end

M.win_set_true = function()
	if M.win_is_valid() then
		-- do nothing
	else
		M.cache.win_handle = vim.api.nvim_open_win(
			M.cache.buf_handle,
			M.config.win_enter,
			M.config.win
		)
		for option, value in pairs(M.config.win_opt) do
			vim.api.nvim_set_option_value(option, value, {win = M.cache.win_handle})
		end
	end
end

-- # function: main

M.record_origin_win = function()
	M.cache.origin_win_handle = vim.api.nvim_get_current_win()
end

M.retrieve_origin_win = function()
	vim.api.nvim_set_current_win(M.cache.origin_win_handle)
end

M.eval = function()
	local lines_tbl = vim.api.nvim_buf_get_lines(M.cache.buf_handle, 0, -1, true)
	local lines_str = table.concat(lines_tbl, " ")
	local cmd = "lua " .. lines_str
	vim.cmd(cmd)
	vim.fn.histadd("cmd", cmd)
end

-- # function: api

M.open = function()
	M.record_origin_win()
	-- M.buf_set_true()
	M.win_set_true()
end

M.close = function()
	M.retrieve_origin_win()
	-- M.buf_set_false()
	M.win_set_false()
end

M.toggle = function()
	if M.win_is_valid() then
		M.close()
	else
		M.open()
	end
end

-- # return

return M
