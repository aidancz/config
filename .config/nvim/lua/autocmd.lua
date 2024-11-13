-- https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup



-- # fix cursor position when changing mode

local cursor_position_augroup = vim.api.nvim_create_augroup("cursor_position", {clear = true})

vim.api.nvim_create_autocmd(
	"InsertLeave",
	{
		group = cursor_position_augroup,
		pattern = {"*"},
		command = "normal `^",
	})



-- # auto save

-- local timer = vim.uv.new_timer()
-- timer:start(0, 100, vim.schedule_wrap(function()
-- 	vim.cmd("echo mode(1)")
-- 	end))

local auto_save_augroup = vim.api.nvim_create_augroup("auto_save", {clear = true})

vim.api.nvim_create_autocmd(
	{"TextChanged", "InsertLeave", "FocusLost"},
	{
		group = auto_save_augroup,
		pattern = {"*"},
		command = "lockmarks silent! wa",
	})

vim.api.nvim_create_autocmd(
	{"QuitPre"},
	{
		group = auto_save_augroup,
		pattern = {"*"},
		nested = true,
		command = "lockmarks silent! wa",
	})

-- https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
-- https://github.com/neovim/neovim/issues/8807



-- # filetype

local filetype_augroup = vim.api.nvim_create_augroup("filetype", {clear = true})

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = filetype_augroup,
		pattern = {"man"},
		callback = function()
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.signcolumn = "no"
		end,
	})



-- # filename

local filename_augroup = vim.api.nvim_create_augroup("filename", {clear = true})

vim.api.nvim_create_autocmd(
	"BufRead",
	{
		group = filename_augroup,
		pattern = {"log.txt"},
		command = "silent $",
	})

vim.api.nvim_create_autocmd(
	"BufRead",
	{
		group = filename_augroup,
		pattern = {"*.txt"},
		command = "set filetype=markdown",
	})
