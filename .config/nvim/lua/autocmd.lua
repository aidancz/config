--[[

vim.api.nvim_create_augroup("xxx", {clear = true})

means:

if augroup_xxx_is_valid then
	clear_autocmds_in_augroup_xxx()
	return augroup_xxx_id
else
	create_augroup_xxx()
	return augroup_xxx_id
end

--]]



-- # fix cursor position when changing mode

vim.api.nvim_create_augroup("switch_mode_cursor_position", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"InsertLeave",
	},
	{
		group = "switch_mode_cursor_position",
		callback = function()
			vim.cmd("normal! `^")
		end,
	}
)

-- local cursor_lnum
-- local cursor_col
-- vim.api.nvim_create_autocmd(
-- 	{
-- 		"InsertLeavePre",
-- 	},
-- 	{
-- 		group = "switch_mode_cursor_position",
-- 		callback = function()
-- 			cursor_lnum = vim.fn.line(".")
-- 			cursor_col = vim.fn.col(".")
-- 		end,
-- 	}
-- )
-- vim.api.nvim_create_autocmd(
-- 	{
-- 		"InsertLeave",
-- 	},
-- 	{
-- 		group = "switch_mode_cursor_position",
-- 		callback = function()
-- 			vim.api.nvim_win_set_cursor(0, {cursor_lnum, cursor_col-1})
-- 		end,
-- 	}
-- )

-- local cursor_lnum
-- local cursor_virtcol
-- vim.api.nvim_create_autocmd(
-- 	{
-- 		"ModeChanged",
-- 	},
-- 	{
-- 		group = "switch_mode_cursor_position",
-- 		pattern = "*:no*",
-- 		callback = function()
-- 			cursor_lnum = vim.fn.line(".")
-- 			cursor_virtcol = vim.fn.virtcol(".", true)[1]
-- 		end,
-- 	}
-- )
-- vim.api.nvim_create_autocmd(
-- 	{
-- 		"ModeChanged",
-- 	},
-- 	{
-- 		group = "switch_mode_cursor_position",
-- 		pattern = "no*:*",
-- 		callback = vim.schedule_wrap(function()
-- 			require("virtcol").set_cursor(cursor_lnum, cursor_virtcol)
-- 		end),
-- 	}
-- )



-- # fix `virtualedit=all` mode

vim.api.nvim_create_augroup("virtualedit_all", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"ModeChanged",
	},
	{
		group = "virtualedit_all",
		pattern = "n:*",
		callback = function()
			vim.o.virtualedit = "onemore"
		end,
	}
)
vim.api.nvim_create_autocmd(
	{
		"ModeChanged",
	},
	{
		group = "virtualedit_all",
		pattern = "*:n",
		callback = vim.schedule_wrap(function()
			if vim.api.nvim_get_mode().mode ~= "n" then return end
			-- `vib` of `mini.ai` actually quit and reenter visual mode, prevent this situation
			vim.o.virtualedit = "all"
		end),
	}
)



-- # auto save

-- vim.api.nvim_create_augroup("auto_save", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	{
-- 		"TextChanged",
-- 		"InsertLeave",
-- 		"FocusLost",
-- 	},
-- 	{
-- 		group = "auto_save",
-- 		command = "lockmarks silent! wa",
-- 	}
-- )
-- vim.api.nvim_create_autocmd(
-- 	{
-- 		"BufLeave",
-- 	},
-- 	{
-- 		group = "auto_save",
-- 		nested = true,
-- 		command = "lockmarks silent! wa",
-- 	}
-- )
-- -- https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
-- -- https://github.com/neovim/neovim/issues/8807



-- # filetype

vim.api.nvim_create_augroup("filetype", {clear = true})
vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "man",
		callback = function()
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.signcolumn = "no"
		end,
	}
)
vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "help",
		callback = function()
			vim.opt_local.buflisted = true
		end,
	}
)



-- # filename

vim.api.nvim_create_augroup("filename", {clear = true})
vim.api.nvim_create_autocmd(
	"BufRead",
	{
		group = "filename",
		pattern = "log.txt",
		command = "silent $",
	}
)
