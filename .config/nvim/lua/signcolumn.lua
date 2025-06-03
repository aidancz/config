local M = {}

M.set_signcolumn0 = function(win)
	vim.api.nvim_set_option_value(
		"signcolumn",
		"yes:2",
		{
			scope = "local",
			win = win,
		}
	)
end

M.set_signcolumn1 = function(win)
	vim.api.nvim_set_option_value(
		"signcolumn",
		"yes:9",
		{
			scope = "local",
			win = win,
		}
	)
end

M.is_floating_window = function(win)
	return
	vim.api.nvim_win_get_config(win).relative ~= ""
end

M.is_normal_buffer_window = function(win)
	return
	vim.api.nvim_get_option_value(
		"buftype",
		{
			buf = vim.api.nvim_win_get_buf(win),
		}
	) == ""
end

M.is_full_width_window = function(win)
	return
	vim.api.nvim_win_get_width(win) == vim.o.columns
end

M.assign_signcolumn = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if M.is_floating_window(win) then
		elseif not M.is_normal_buffer_window(win) then
		elseif M.is_full_width_window(win) then
			M.set_signcolumn1(win)
		else
			M.set_signcolumn0(win)
		end
	end
end

vim.api.nvim_create_augroup("signcolumn", {clear = true})
vim.api.nvim_create_autocmd(
	{
		"VimEnter",
		"WinNew",
		"WinClosed",
		"WinResized",
	},
	{
		group = "signcolumn",
		callback = function()
			vim.schedule(function()
				M.assign_signcolumn()
			end)
		end,
	}
)

return M
