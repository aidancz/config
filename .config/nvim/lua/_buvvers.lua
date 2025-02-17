vim.opt.runtimepath:prepend("~/sync_git/buvvers.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/buvvers.nvim",
-- })

require("buvvers").setup({
})
require("buvvers").open()

vim.keymap.set("n", "<a-b>", require("buvvers").toggle)

local quit_win_augroup = vim.api.nvim_create_augroup("quit_win", {clear = true})
vim.api.nvim_create_autocmd(
	{"WinClosed"},
	{
		group = quit_win_augroup,
		callback = function(event)
			local closing_window_handle = tonumber(event.match)
			for _, i in ipairs(vim.api.nvim_list_wins()) do
				if i == closing_window_handle then
					-- do nothing
				elseif vim.fn.buflisted(vim.api.nvim_win_get_buf(i)) ~= 0 then
					return
				end
			end
			vim.cmd("qa!")
		end,
	})
-- HACK: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
