-- open outline.nvim in require("mini.deps").now:
-- 	1. long startup time
-- open outline.nvim in require("mini.deps").later:
-- 	1. ui shake
-- let's make the ui does not shake:

vim.schedule(function()
	local window_handle = vim.api.nvim_open_win(
		vim.api.nvim_create_buf(false, true),
		false,
		{
			win = -1,
			split = "left",
			width = math.ceil(vim.o.columns / 8),
		}
	)

	vim.api.nvim_create_autocmd(
		"WinNew",
		{
			callback = function()
				vim.api.nvim_win_close(window_handle, true)
			end,
			once = true,
		}
	)
end)
