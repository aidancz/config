-- https://neovim.io/doc/user/faq.html
-- CURSOR STYLE ISN'T RESTORED AFTER EXITING OR SUSPENDING AND RESUMING NVIM

local M = {}

M.set_cursor0 = function()
	vim.o.guicursor = ""
end

M.set_cursor1 = function()
	vim.o.guicursor = ""
end

vim.api.nvim_create_augroup("guicursor", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"VimEnter",
		"VimResume",
	},
	{
		group = "guicursor",
		callback = function()
		end,
	}
)

vim.api.nvim_create_autocmd(
	{
		"VimLeave",
		"VimSuspend",
	},
	{
		group = "guicursor",
		callback = function()
		end,
	}
)
