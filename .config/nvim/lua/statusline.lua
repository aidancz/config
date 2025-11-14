-- https://www.reddit.com/r/neovim/comments/tz6p7i/how_can_we_set_color_for_each_part_of_statusline/

local M = {}
local H = {}

-- # set statusline

vim.go.statusline = "%{%v:lua.statusline()%}"

-- # function: main

M.str = function()
	if vim.o.laststatus == 3 then
		return M.str_active()
	end

	if vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin) then
		return M.str_active()
	else
		return M.str_inactive()
	end
end
statusline = M.str

M.str_active = function()
	local lhs
	lhs = {
		M.buffer_name(),
		M.encoding(),
		M.eol(),
		M.cwd(),
		M.undotree(),
		-- M.test(),
	}
	lhs = vim.tbl_filter(function(x) return x ~= nil end, lhs)

	local rhs
	rhs = {
		M.macro(),
		M.hydra(),
		M.mode(),
		M.col(),
		M.lnum(),
	}
	rhs = vim.tbl_filter(function(x) return x ~= nil end, rhs)

	return table.concat({
		table.concat(lhs, " "),
		"%<",
		"%=",
		table.concat(rhs, " "),
	})
end

M.str_inactive = function()
	return table.concat({
		"%f",
	})
end

-- # function: help

H.highlight = function(str, hl)
-- https://github.com/neovim/neovim/issues/32925
	return table.concat({
		"%#",
		hl,
		"#",
		str,
		"%*",
	})
end

---@param str string
---@param opts {
---	justify?: "left"|"right",
---	minwid?: number,
---	maxwid?: number,
---}
H.format = function(str, opts)
	return table.concat({
		"%",
		opts.justify == "left" and "-" or "",
		opts.minwid or 1, -- https://github.com/vim/vim/issues/14993
		".",
		opts.maxwid or "",
		"(",
		str,
		"%)",
	})
end

--[[

H.truncate = function(str, max_char_length)
	if vim.fn.strchars(str) > max_char_length then
		return vim.fn.strcharpart(str, 0, max_char_length) .. "…"
	else
		return str
	end
end

H.truncate_r = function(str, max_char_length)
	-- local reverse = string.reverse
	local reverse
	reverse = function(str)
		if str == "" then
			return ""
		else
			local len = vim.fn.strchars(str)
			return
			vim.fn.strcharpart(str, (len-1), 1)
			..
			reverse(vim.fn.strcharpart(str, 0, (len-1)))
		end
	end
	return reverse(H.truncate(reverse(str), max_char_length))
end

H.pad = function(expr_str, min_screen_width)
	local width = vim.api.nvim_eval_statusline(expr_str, {}).width
	if width < min_screen_width then
		return expr_str .. string.rep(" ", min_screen_width - width)
	else
		return expr_str
	end
end

H.pad_r = function(expr_str, min_screen_width)
	local width = vim.api.nvim_eval_statusline(expr_str, {}).width
	if width < min_screen_width then
		return string.rep(" ", min_screen_width - width) .. expr_str
	else
		return expr_str
	end
end

--]]

-- # component

M.test = function()
	local component

	component = table.concat({
		"(",
		get_time(),
		")",
	})
	component = H.format(component, {
	})

	return component
end

M.buffer_name = function()
	local component

	component = table.concat({
		"%f",
		-- "%m",
	})
	component = H.format(component, {
		justify = "left",
	})

	return component
end

M.col = function()
	local component

	local col_cursor = vim.fn.col(".")
	local col_last = vim.fn.col("$")

	component = table.concat({
		"(",
		H.highlight(col_cursor, "nofrils_blue"),
		" ",
		col_last,
		")",
	})
	component = H.format(component, {
		justify = "left",
		minwid = (3 + 2 * 3),
	})

	return component
end

M.cwd = function()
	local component

	local cwd = vim.fn.getcwd()
	local cwd1 = vim.fs.basename(cwd)

	component = table.concat({
		"(",
		cwd1,
		")",
	})
	component = H.format(component, {
	})

	return component
end

M.encoding = function()
	local component

	local encoding = vim.bo.fileencoding
	if
		encoding == ""
		or
		encoding == "utf-8"
	then
		return nil
	end

	component = table.concat({
		"(",
		encoding,
		")",
	})
	component = H.highlight(component, "nofrils_blue_bg")
	component = H.format(component, {
	})

	return component
end

M.eol = function()
	local component

	local eol = vim.bo.fileformat
	if
		eol == "unix"
	then
		return nil
	end

	component = table.concat({
		"(",
		eol,
		")",
	})
	component = H.highlight(component, "nofrils_blue_bg")
	component = H.format(component, {
	})

	return component
end

M.hydra = function()
	local component

	local m = package.loaded["hydra"]
	if m == nil then return nil end

	local is_active = require("hydra.statusline").is_active()
	local name = require("hydra.statusline").get_name()

	component = table.concat({
		"(",
		name or "hydra",
		")",
	})
	if is_active then
		component = H.highlight(component, "nofrils_blue_bg")
	end
	component = H.format(component, {
	})

	return component
end

M.lnum = function()
	local component

	local lnum_cursor = vim.fn.line(".")
	local lnum_last = vim.fn.line("$")

	component = table.concat({
		"(",
		H.highlight(lnum_cursor, "nofrils_blue"),
		" ",
		lnum_last,
		")",
	})
	component = H.format(component, {
		justify = "right",
		minwid = (3 + 2 * 4),
	})

	return component
end

M.macro = function()
	local component

	local m = package.loaded["macro"]
	if m == nil then return nil end

	local lis = m.get_lis()
	local reg = m.get_reg()

	local lis1 = ""
	for _, i in ipairs(lis) do
		if i == reg then
			lis1 = lis1 .. H.highlight(i, "nofrils_blue")
		else
			lis1 = lis1 .. i
		end
	end

	component = table.concat({
		"(",
		lis1,
		")",
	})
	component = H.format(component, {
		-- justify = "left",
		minwid = (2 + #lis),
	})

	return component
end

M.mode = function()
	local component

	local mode = vim.api.nvim_get_mode().mode

	component = table.concat({
		"(",
		mode,
		")",
	})
	if mode ~= "n" then
		component = H.highlight(component, "nofrils_blue_bg")
	end
	component = H.format(component, {
	})

	return component
end

M.undotree = function()
	local component

	if vim.bo.buftype ~= "" then
		component = ""
		return component
	end

	local undotree = vim.fn.undotree()
	local first = 0
	local last = #undotree.entries
	local current
	if
		undotree.seq_cur == 0
		or
		last == 0
	then
		current = 0
	else
		for index, undo_item in ipairs(undotree.entries) do
			if undo_item.seq == undotree.seq_cur then
				current = index
				break
			end
		end
	end
	local undo = first - current
	undo = math.abs(undo)
	local redo = last - current

	component = table.concat({
		"(",
		undo,
		" ",
		redo,
		")",
	})
	component = H.format(component, {
	})

	return component
end

-- # return

return M
