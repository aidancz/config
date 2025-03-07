vim.opt.runtimepath:prepend("~/sync_git/buvvers.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/buvvers.nvim",
-- })

require("buvvers").setup({
	highlight_group_current_buffer = "Visual",
	name_prefix = function(buffer_handle)
		local icon, hl = MiniIcons.get("file", vim.api.nvim_buf_get_name(buffer_handle))
		return {
			icon .. " ",
			hl,
		}
		-- return "○ "
	end,
})

vim.keymap.set("n", "<c-s-b>", require("buvvers").toggle)

vim.api.nvim_create_autocmd(
	"User",
	{
		group = vim.api.nvim_create_augroup("buvvers_keymap", {clear = true}),
		pattern = "BuvversAttach",
		callback = function()
			vim.keymap.set(
				"n",
				"d",
				function()
					local current_buf_handle = require("buvvers").get_current_buf_handle()
					MiniBufremove.delete(current_buf_handle, false)
				end,
				{
					buffer = require("buvvers").get_buvvers_buf_handle(),
					nowait = true,
				}
			)
			vim.keymap.set(
				"n",
				"o",
				function()
					local current_buf_handle = require("buvvers").get_current_buf_handle()
					local previous_win_handle = vim.fn.win_getid(vim.fn.winnr("#"))
					-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/0b44040ec7b8472dfc504bbcec735419347797ad/lua/neo-tree/utils/init.lua#L643
					vim.api.nvim_win_set_buf(previous_win_handle, current_buf_handle)
					vim.api.nvim_set_current_win(previous_win_handle)
				end,
				{
					buffer = require("buvvers").get_buvvers_buf_handle(),
					nowait = true,
				}
			)
		end,
	})

require("buvvers").open()



-- local quit_win_augroup = vim.api.nvim_create_augroup("quit_win", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	{"WinClosed"},
-- 	{
-- 		group = quit_win_augroup,
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
-- 	})
-- -- HACK: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
