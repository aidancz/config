local M = {}
local H = {}

-- # config & setup

M.config = {
	buf_name = "[luaeval]",
	buf_opt = {
		filetype = "lua",
	},
	win = {
		relative = "editor",
		anchor = "NE",
		-- border = "bold",
		row = 0,
		col = vim.o.columns,
		width = math.floor(vim.o.columns / 2),
		height = vim.o.lines - vim.o.cmdheight - 1 - 2,
		title = "luaeval",
	},
	win_enter = true,
	win_opt = {
		winfixbuf = true,
		winfixwidth = true,
		winfixheight = true,
	},
	hook_open = nil,
	hook_close = nil,
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
	end
end

M.buf_set_lines = function(lines)
	vim.api.nvim_buf_set_lines(
		M.cache.buf_handle,
		0,
		-1,
		true,
		lines
	)
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

M.code2cmd = require("luaexec").code2cmd

M.cmd2code = require("luaexec").cmd2code

M.exec = require("luaexec").exec

M.wrap = function(code_tbl, wrap)
	if wrap == nil then
		return
	elseif wrap == "vim.print" then
		table.insert(code_tbl, 1, "vim.print(")
		table.insert(code_tbl, ")")
	elseif wrap == "vim.cmd" then
		table.insert(code_tbl, 1, "vim.cmd([[")
		table.insert(code_tbl, "]])")
	elseif wrap == "vim.cmd.normal" then
		table.insert(code_tbl, 1, "vim.cmd.normal([[")
		code_tbl[#code_tbl] = code_tbl[#code_tbl] .. "]])"
	elseif wrap == "vim.api.nvim_feedkeys" then
		table.insert(code_tbl, 1, "vim.api.nvim_feedkeys([[")
		code_tbl[#code_tbl] = code_tbl[#code_tbl] .. "]], [[t]], true)"
	end
end

M.eval = function(wrap)
	local code_tbl = vim.api.nvim_buf_get_lines(M.cache.buf_handle, 0, -1, true)
	M.wrap(code_tbl, wrap)
	M.exec(code_tbl, true)
end

M.open = function()
	M.win_set_true()
	M.config.hook_open()
end

M.close = function()
	M.win_set_false()
	M.config.hook_close()
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
