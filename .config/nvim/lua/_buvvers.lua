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
	buf_hook = function(buf)
		vim.keymap.set(
			"n",
			"x",
			function()
				local listed_bufs = require("buvvers").get_listed_bufs()
				local buf_cursor = listed_bufs[vim.fn.line(".")]
				require("mini.bufremove").delete(buf_cursor, false)
			end,
			{
				buffer = buf,
				nowait = true,
			}
		)
		vim.keymap.set(
			"n",
			"o",
			function()
				local listed_bufs = require("buvvers").get_listed_bufs()
				local buf_cursor = listed_bufs[vim.fn.line(".")]
				local win_previous = vim.fn.win_getid(vim.fn.winnr("#"))
				-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/0b44040ec7b8472dfc504bbcec735419347797ad/lua/neo-tree/utils/init.lua#L643
				vim.api.nvim_win_set_buf(win_previous, buf_cursor)
				vim.api.nvim_set_current_win(win_previous)
			end,
			{
				buffer = buf,
				nowait = true,
			}
		)
	end,
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

require("buvvers").open()

require("luaexec").add({
	code = [[require("buvvers").toggle()]],
	from = "buvvers",
	name = "window",
})
