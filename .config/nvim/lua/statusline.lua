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
	return
	table.concat(
		{
			M.buffer_name(),
			"%<",
			"%=",
			M.macro(),
			" ",
			M.col(),
			" ",
			M.lnum(),
		},
		""
	)
end

M.str_inactive = function()
	return
	table.concat(
		{
			"%f",
		},
		""
	)
end

-- # function: help

H.highlight = function(str, hl)
	return
	table.concat(
		{
			"%#",
			hl,
			"#",
			str,
			"%*",
		},
		""
	)
end

H.highlight_workaround = function(str, hl)
-- https://github.com/neovim/neovim/issues/32925
	return
	table.concat(
		{
			"%#",
			hl,
			"#",
			str,
			"%#StatusLine#",
		},
		""
	)
end

---@param str string
---@param opts {
---	justify?: "left"|"right",
---	minwid?: number,
---	maxwid?: number,
---}
H.format = function(str, opts)
	return
	table.concat(
		{
			"%",
			opts.justify == "left" and "-" or "",
			opts.minwid or "",
			".",
			opts.maxwid or "",
			"(",
			str,
			"%)",
		},
		""
	)
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

-- # mode

M.mode = function()
	local component

	component = table.concat(
		{
			"(",
			vim.api.nvim_get_mode().mode,
			")",
		},
		""
	)
	component = H.format(
		component,
		{
			justify = "left",
			minwid = (2 + 1),
		}
	)

	return component
end

-- # buffer_name

M.buffer_name = function()
	local component

	component = table.concat(
		{
			"%f",
			-- "%m",
		},
		""
	)
	component = H.format(
		component,
		{
			justify = "left",
		}
	)

	return component
end

-- # lnum

M.lnum = function()
	local component

	local lnum_cursor = vim.fn.line(".")
	local lnum_last = vim.fn.line("$")

	component = table.concat(
		{
			"(",
			H.highlight(lnum_cursor, "nofrils-blue"),
			" ",
			lnum_last,
			")",
		},
		""
	)
	component = H.format(
		component,
		{
			justify = "right",
			minwid = (3 + 2 * 4),
		}
	)

	return component
end

-- # col

M.col = function()
	local component

	local col_cursor = vim.fn.col(".")
	local col_last = vim.fn.col("$")

	component = table.concat(
		{
			"(",
			H.highlight(col_cursor, "nofrils-blue"),
			" ",
			col_last,
			")",
		},
		""
	)
	component = H.format(
		component,
		{
			justify = "left",
			minwid = (3 + 2 * 3),
		}
	)

	return component
end

-- # macro

local keys = {
-- https://github.com/folke/which-key.nvim
	["<Up>"]              = "",
	["<Down>"]            = "",
	["<Left>"]            = "",
	["<Right>"]           = "",
	["<PageUp>"]          = "󰳢",
	["<PageDown>"]        = "󰳜",
	["<Home>"]            = "󰳞",
	["<End>"]             = "󰳠",
	["<C%-(.-)>"]         = function(capture) return "󰘴" .. capture end,
	["<M%-(.-)>"]         = function(capture) return "󰘵" .. capture end,
	["<D%-(.-)>"]         = function(capture) return "󰘳" .. capture end,
	["<S%-(.-)>"]         = function(capture) return "󰘶" .. capture end,
	["<CR>"]              = "󰌑",
	["<Esc>"]             = "󰧃",
	["<ScrollWheelDown>"] = "󱕐",
	["<ScrollWheelUp>"]   = "󱕑",
	["<NL>"]              = "󰌑",
	["<BS>"]              = "󰁮",
	["<Del>"]             = "󰹾",
	["<Space>"]           = "󱁐",
	["<Tab>"]             = "󰌒",
	["<F1>"]              = "󱊫",
	["<F2>"]              = "󱊬",
	["<F3>"]              = "󱊭",
	["<F4>"]              = "󱊮",
	["<F5>"]              = "󱊯",
	["<F6>"]              = "󱊰",
	["<F7>"]              = "󱊱",
	["<F8>"]              = "󱊲",
	["<F9>"]              = "󱊳",
	["<F10>"]             = "󱊴",
	["<F11>"]             = "󱊵",
	["<F12>"]             = "󱊶",
}

	-- ## add highlight
	local highlight_replacement = function(repl)
		if type(repl) == "string" then
			return
			function()
				local str = repl
				return H.highlight(str, "nofrils-yellow")
			end
		elseif type(repl) == "function" then
			return
			function(capture)
				local str = repl(capture)
				return H.highlight(str, "nofrils-yellow")
			end
		end
	end
	-- string.gsub("<BS>", "<BS>", "%#nofrils-yellow#󰁮%*") => #nofrils-yellow#󰁮*
	-- string.gsub("<BS>", "<BS>", function() return "%#nofrils-yellow#󰁮%*" end) => %#nofrils-yellow#󰁮%*
	-- so we use function

local format_visual = function(str)
	for pattern, replacement in pairs(keys) do
		str = string.gsub(str, pattern, highlight_replacement(replacement))
	end
	return str
end

M.macro = function()
	local component

	local m = package.loaded["macro"]
	if not m then
		component = ""
		return component
	end

	local lis = m.get_lis()
	local reg = m.get_reg()

	local lis1 = ""
	for _, i in ipairs(lis) do
		if i == reg then
			lis1 = lis1 .. H.highlight_workaround(i, "nofrils-blue-bg")
		else
			lis1 = lis1 .. i
		end
	end

	local macro1 = m.get_macro(reg)
	local macro2 = m.internal2visual(macro1)
	local macro3 = format_visual(macro2)

	local macro_maxwid = 8
	component = table.concat(
		{
			"(",
			lis1,
			" ",
			'"',
			H.format(macro3, {maxwid = macro_maxwid}),
			'"',
			")",
		},
		""
	)
	component = H.format(
		component,
		{
			justify = "left",
			minwid = (3 + #lis + (2 + macro_maxwid)),
		}
	)

	return component
end

-- # return

return M
