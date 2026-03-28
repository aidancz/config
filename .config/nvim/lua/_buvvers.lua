vim.opt.runtimepath:prepend("~/sync_git/buvvers.nvim")

vim.api.nvim_create_augroup("quit_win", {clear = true})
vim.api.nvim_create_autocmd(
	"WinClosed",
	{
		group = "quit_win",
		callback = function(event)
			local wins = vim.api.nvim_list_wins()

			local win_closing = tonumber(event.match)
			local is_closing_window = function(win)
				return win == win_closing
			end
			local is_floating_window = function(win)
				return vim.api.nvim_win_get_config(win).relative ~= ""
			end

			local wins_filtered = vim.tbl_filter(
				function(win)
					return not (is_closing_window(win) or is_floating_window(win))
				end,
				wins
			)

			-- vim.print(wins_filtered)

			if
				#wins_filtered == 1
				and
				vim.bo[vim.api.nvim_win_get_buf(wins_filtered[1])].filetype == "buvvers"
			then
				-- vim.cmd("qa!") -- NOTE: affect VimLeave autocmd
				vim.schedule(function() vim.cmd("qa!") end)
			else
				-- do nothing
			end
		end,
	}
)
-- HACK: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close

require("buvvers").setup({
	highlight_group_current_buffer = "nofrils_reverse",
	buffer_handle_list_to_buffer_name_list = function(handle_l)
		local name_l

		local default_function = require("buvvers.buffer_handle_list_to_buffer_name_list")
		name_l = default_function(handle_l)

		for n, name in ipairs(name_l) do
			local icon, hl = require("mini.icons").get("file", name)
			name_l[n] = {
				-- {icon, hl},
				icon,
				" ",
				name,
			}
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
