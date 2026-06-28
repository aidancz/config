local M = {}

M.get_gutter = function(width)
	local gutter = {
		foldcolumn = "1",

		signcolumn = "yes:2",

		numberwidth = 3,
		number = false,
		relativenumber = true,

		statuscolumn = "%C%s%2l ",
		-- https://github.com/neovim/neovim/pull/20621
	}

	local width_delta = width - 8
	gutter.statuscolumn = string.rep(" ", width_delta) .. gutter.statuscolumn

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

M.is_main_window = function(win)
	return
	vim.api.nvim_win_get_width(win) >= (vim.o.columns * 3/4)
end

M.gutter_on = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if M.is_exclusive_window(win) then
			-- do nothing
		elseif M.is_main_window(win) then
			M.set_gutter1(win)
		else
			M.set_gutter0(win)
		end
	end
end

M.gutter_off = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if M.is_exclusive_window(win) then
			-- do nothing
		elseif M.is_main_window(win) then
			M.set_gutter0(win)
		else
			M.set_gutter0(win)
		end
	end
end

M.augroup = vim.api.nvim_create_augroup("gutter", {clear = true})

M.autocmd_is_on = function()
	local autocmds = vim.api.nvim_get_autocmds({group = M.augroup})
	return not vim.tbl_isempty(autocmds)
end

M.autocmd_on = function()
	if M.autocmd_is_on() then
		-- do nothing
	else
		vim.api.nvim_create_autocmd(
			{
				-- "VimEnter",
				-- "WinNew",
				-- "WinClosed",
				"WinResized",
				"BufEnter",
			},
			{
				group = "gutter",
				callback = function()
					M.gutter_on()
				end,
			}
		)
	end
end

M.autocmd_off = function()
	if M.autocmd_is_on() then
		vim.api.nvim_clear_autocmds({group = M.augroup})
	else
		-- do nothing
	end
end

M.on = function()
	M.gutter_on()
	M.autocmd_on()
end

M.off = function()
	M.autocmd_off()
	M.gutter_off()
end

M.tog = function()
	if M.autocmd_is_on() then
		M.off()
	else
		M.on()
	end
end

return M
