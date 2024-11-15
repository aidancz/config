local M = require("eolmark/eolmark")

local eol_extmark_augroup = vim.api.nvim_create_augroup("eol_extmark", {clear = true})

vim.api.nvim_create_autocmd(
	{"BufEnter", "CursorMoved", "CursorMovedI"},
	{
		group = eol_extmark_augroup,
		callback = M.show_at_cursor_line,
	})

vim.api.nvim_set_hl(0, "EolExtmark", {link = "LineNr"})
