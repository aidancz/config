-- open outline.nvim in require("mini.deps").now:
-- 	1. long startup time
-- open outline.nvim in require("mini.deps").later:
-- 	1. ui shake
-- let's make the ui does not shake:

vim.schedule(function()
	local buf = vim.api.nvim_create_buf(
		false,
		true
	)
	vim.api.nvim_buf_set_name(buf, "OUTLINE")
	local win = vim.api.nvim_open_win(
		buf,
		false,
		{
			win = -1,
			split = "left",
			width = math.ceil(vim.o.columns / 8),
			style = "minimal",
		}
	)
	vim.api.nvim_create_autocmd(
		"WinNew",
		{
			callback = vim.schedule_wrap(function()
				for _, winid in ipairs(vim.api.nvim_list_wins()) do
					local bufid = vim.api.nvim_win_get_buf(winid)
					local bufname = vim.api.nvim_buf_get_name(bufid)
					if string.find(bufname, "OUTLINE_") ~= nil then
						vim.api.nvim_win_close(win, true)
						break
					end
				end
			end),
			once = true,
		}
	)
end)
