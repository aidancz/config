vim.opt.runtimepath:prepend("~/sync_git/buvvers.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/buvvers.nvim",
-- })

-- vim.api.nvim_create_augroup("quit_win", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	"WinClosed",
-- 	{
-- 		group = "quit_win",
-- 		callback = function(event)
-- 			local closing_window_handle = tonumber(event.match)
-- 			for _, i in ipairs(vim.api.nvim_list_wins()) do
-- 				if i == closing_window_handle then
-- 					-- do nothing
-- 				elseif vim.fn.buflisted(vim.api.nvim_win_get_buf(i)) ~= 0 then
-- 					return
-- 				end
-- 			end
-- 			vim.cmd("qa!")
-- 		end,
-- 	}
-- )
-- -- HACK: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close

require("buvvers").setup({
	buvvers_win = {
	},
	buvvers_win_enter = false,
	buvvers_win_opt = {
	},
	buffer_handle_list_to_buffer_name_list = function(handle_l)
		local name_l

		local default_function = require("buvvers.buffer_handle_list_to_buffer_name_list")
		name_l = default_function(handle_l)

		for n, name in ipairs(name_l) do
			name_l[n] = "󰈔 " .. name
		end

		return name_l
	end,
})

vim.keymap.set("n", "fb", require("buvvers").toggle)

local add_buffer_keybindings = function()
	vim.keymap.set(
		"n",
		"d",
		function()
			local cursor_buf_handle = require("buvvers").buvvers_buf_get_buf(vim.fn.line("."))
			MiniBufremove.delete(cursor_buf_handle, false)
		end,
		{
			buffer = require("buvvers").buvvers_get_buf(),
			nowait = true,
		}
	)
	vim.keymap.set(
		"n",
		"o",
		function()
			local cursor_buf_handle = require("buvvers").buvvers_buf_get_buf(vim.fn.line("."))
			local previous_win_handle = vim.fn.win_getid(vim.fn.winnr("#"))
			-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/0b44040ec7b8472dfc504bbcec735419347797ad/lua/neo-tree/utils/init.lua#L643
			vim.api.nvim_win_set_buf(previous_win_handle, cursor_buf_handle)
			vim.api.nvim_set_current_win(previous_win_handle)
		end,
		{
			buffer = require("buvvers").buvvers_get_buf(),
			nowait = true,
		}
	)
end
vim.api.nvim_create_augroup("buvvers_config", {clear = true})
vim.api.nvim_create_autocmd(
	"User",
	{
		group = "buvvers_config",
		pattern = "BuvversBufEnabled",
		callback = add_buffer_keybindings,
	}
)

vim.schedule(require("buvvers").open)
