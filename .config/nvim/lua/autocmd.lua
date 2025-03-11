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

vim.api.nvim_create_augroup("esc_cursor_position", {clear = true})
vim.api.nvim_create_autocmd(
	{
		"InsertLeave",
	},
	{
		group = "esc_cursor_position",
		command = "normal `^",
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
