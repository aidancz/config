-- https://www.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/
-- https://www.reddit.com/r/neovim/comments/1k4efz8/comment/mola3k0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

local M = {}

-- # line comment

-- M.comment_from_a_to_b = function(pos10_a, pos10_b)
-- -- cannot use dot-repeat in this form
-- 	vim.cmd({
-- 		range = {
-- 			pos10_a[1],
-- 			pos10_b[1],
-- 		},
-- 		cmd = "normal",
-- 		args = {
-- 			"gcc",
-- 		},
-- 	})
-- end

-- M.comment_from_a_to_b = function(pos10_a, pos10_b)
-- 	require("mini.comment").toggle_lines(pos10_a[1], pos10_b[1])
-- end

M.comment_from_a_to_b = function(pos10_a, pos10_b)
	require("Comment.api").toggle.linewise("fuck")
	-- require("Comment.utils").get_region
end

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

	M.comment_from_a_to_b(pos10_a, pos10_b)

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

-- # block comment

M.comment_from_a_to_b_block = function(pos10_a, pos10_b)
	require("Comment.api").toggle.blockwise("fuck")
	-- require("Comment.utils").get_region
end

M.operatorfunc_block = function(_)
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

	M.comment_from_a_to_b_block(pos10_a, pos10_b)

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
