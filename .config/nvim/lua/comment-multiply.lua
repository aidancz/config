-- https://www.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/
-- https://www.reddit.com/r/neovim/comments/1k4efz8/comment/mola3k0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

local M = {}

M.operatorfunc = function(_)
	local pos10_a = vim.api.nvim_buf_get_mark(0, "[")
	local pos10_b = vim.api.nvim_buf_get_mark(0, "]")
	local pos00_a = {
		pos10_a[1] - 1,
		pos10_a[2],
	}
	local pos00_b = {
		pos10_b[1] - 1,
		pos10_b[2],
	}

	local lines = vim.api.nvim_buf_get_lines(0, pos00_a[1], pos00_b[1] + 1, true)

	-- vim.cmd({
	-- 	range = {
	-- 		pos10_a[1],
	-- 		pos10_b[1],
	-- 	},
	-- 	cmd = "normal",
	-- 	args = {
	-- 		"gcc",
	-- 	},
	-- })

	require("mini.comment").toggle_lines(pos10_a[1], pos10_b[1])

	vim.api.nvim_buf_set_lines(
		0,
		pos00_b[1] + 1,
		pos00_b[1] + 1,
		true,
		lines
	)

	vim.api.nvim_win_set_cursor(0, {pos10_b[1] + 1, 0})
	vim.cmd("normal! _")
end

return M
