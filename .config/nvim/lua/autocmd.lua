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



-- # save window view

vim.api.nvim_create_augroup("save_window_view", {clear = true})
vim.api.nvim_create_autocmd(
	"BufWinLeave",
	{
		group = "save_window_view",
		callback = function()
			vim.b.winview = vim.fn.winsaveview()
		end,
	}
)
vim.api.nvim_create_autocmd(
	"BufWinEnter",
	{
		group = "save_window_view",
		callback = function()
			if vim.b.winview then
				vim.fn.winrestview(vim.b.winview)
			end
		end,
	}
)
-- https://www.reddit.com/r/neovim/comments/11dmaed/keep_buffer_view_when_you_return_to_file/



-- # filetype

vim.api.nvim_create_augroup("filetype", {clear = true})

local clear_gutter = function()
	vim.opt_local.foldcolumn = "0"
	vim.opt_local.signcolumn = "no"
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.statuscolumn = ""
end

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "man",
		callback = function()
			clear_gutter()
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
			clear_gutter()
		end,
	}
)

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "qf",
		callback = function()
			vim.cmd("wincmd J")
			-- https://vi.stackexchange.com/questions/38713/quickfix-window-default-postion
		end,
	}
)

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "query",
		callback = function()
			vim.cmd([[setl iskeyword+=+,-,*,/,%,<,=,>,:,$,?,!,@-@,94]])
		end,
	}
)
-- :autocmd InsertLeave
-- $VIMRUNTIME/lua/vim/treesitter/dev.lua	local cursor_word = vim.fn.expand('<cword>') --[[@as string]]
-- $VIMRUNTIME/ftplugin/query.lua		vim.cmd([[runtime! ftplugin/lisp.vim]])
-- $VIMRUNTIME/ftplugin/lisp.vim		setl iskeyword+=+,-,*,/,%,<,=,>,:,$,?,!,@-@,94



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
