local M = {}

M.get_gutter = function(width)
	local gutter = {
		foldcolumn = "1",
		signcolumn = "yes:2",
		numberwidth = 3,
		statuscolumn = "%C%s%l ",
		-- https://github.com/neovim/neovim/pull/20621
	}
	local width_delta = width - (1 + 2 * 2 + 3)
	assert(width_delta >= 0)
	local width_delta_signcolumn_can_provide = 7 * 2
	-- "yes:2" ~ "yes:9"
	if width_delta <= width_delta_signcolumn_can_provide then
		gutter.signcolumn = "yes:" .. (2 + math.floor(width_delta / 2))
	else
		gutter.signcolumn = "yes:9"
		gutter.statuscolumn = string.rep(" ", width_delta - width_delta_signcolumn_can_provide) .. "%C%s%l "
	end
	return gutter
end

M.set_gutter = function(win, gutter)
	for option, value in pairs(gutter) do
		vim.api.nvim_set_option_value(
			option,
			value,
			{
				scope = "local",
				win = win,
			}
		)
	end
end

M.set_gutter0 = function(win)
	local gutter = M.get_gutter(8)
	M.set_gutter(win, gutter)
end

M.set_gutter1 = function(win)
	local gutter = M.get_gutter(math.floor(vim.o.columns / 6))
	M.set_gutter(win, gutter)
end

M.is_exclusive_window = function(win)
	return
	vim.api.nvim_win_get_config(win).relative ~= ""
	or
	vim.api.nvim_get_option_value(
		"buftype",
		{
			buf = vim.api.nvim_win_get_buf(win),
		}
	) ~= ""
end

M.is_full_width_window = function(win)
	return
	vim.api.nvim_win_get_width(win) == vim.o.columns
end

M.assign_gutter = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if M.is_exclusive_window(win) then
			-- do nothing
		elseif M.is_full_width_window(win) then
			M.set_gutter1(win)
		else
			M.set_gutter0(win)
		end
	end
end

vim.api.nvim_create_augroup("gutter", {clear = true})
vim.api.nvim_create_autocmd(
	{
		"VimEnter",
		"WinNew",
		"WinClosed",
		"WinResized",
	},
	{
		group = "gutter",
		callback = function()
			M.assign_gutter()
		end,
	}
)

return M
