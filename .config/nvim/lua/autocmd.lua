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
	vim.wo.foldcolumn = "0"
	vim.wo.signcolumn = "no"
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.statuscolumn = ""
end

-- ## man

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

-- ## help

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "help",
		callback = function()
			-- vim.bo.buflisted = true
			clear_gutter()
		end,
	}
)

-- ## qf

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

-- ## query

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

-- # used before

--[=[

-- # auto save

vim.api.nvim_create_augroup("auto_save", {clear = true})
vim.api.nvim_create_autocmd(
	{
		"TextChanged",
		"InsertLeave",
		"FocusLost",
	},
	{
		group = "auto_save",
		command = "lockmarks silent! wa",
	}
)
vim.api.nvim_create_autocmd(
	{
		"BufLeave",
	},
	{
		group = "auto_save",
		nested = true,
		command = "lockmarks silent! wa",
	}
)
-- https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
-- https://github.com/neovim/neovim/issues/8807

-- # floating window zindex

vim.api.nvim_create_augroup("floating_window_zindex", {clear = true})
vim.api.nvim_create_autocmd(
	"WinNew",
	{
		group = "floating_window_zindex",
		callback = function()
			local win = vim.api.nvim_get_current_win()
			local win_config = vim.api.nvim_win_get_config(win)
			if
				win_config.relative ~= ""
				and
				win_config.zindex < 200
			then
				vim.api.nvim_win_set_config(
					win,
					{
						zindex = 200,
					}
				)
			end
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

--]=]
