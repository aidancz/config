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
	local list = {
		"%t",
		"%m",
		"%<",
		"%=",
		"%=",
		"%=",
		"%=",
		H.pad(
			M.macro(),
			16
		),
		"%=",
		H.pad(
			M.col(),
			9
		),
		"%=",
		H.pad_r(
			M.lnum(),
			13
		),
	}
	return table.concat(list, "")
end

M.str_inactive = function()
	local list = {
		"%t",
	}
	return table.concat(list, "")
end

-- # function: help

H.highlight = function(str, hl)
	return
	"%#" .. hl .. "#" .. str .. "%*"
end

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

-- # col

M.col = function()
	local col_cursor = math.max(1, vim.fn.col("."))
	local col_last = vim.fn.col("$")
	return
	string.format(
		"(%s %s)",
		col_cursor,
		H.highlight(col_last, "nofrils-blue")
	)
end

-- # lnum

M.lnum = function()
	local lnum_cursor = vim.fn.line(".")
	local lnum_last = vim.fn.line("$")
	return
	string.format(
		"(%s %s)",
		lnum_cursor,
		H.highlight(lnum_last, "nofrils-blue")
	)
end

-- # macro

local keys = {
-- https://github.com/folke/which-key.nvim
	["<Up>"]              = "",
	["<Down>"]            = "",
	["<Left>"]            = "",
	["<Right>"]           = "",
	["<C%-(.-)>"]         = function(capture) return "󰘴" .. capture end,
	["<M%-(.-)>"]         = function(capture) return "󰘵" .. capture end,
	["<D%-(.-)>"]         = function(capture) return "󰘳" .. capture end,
	["<S%-(.-)>"]         = function(capture) return "󰘶" .. capture end,
	["<CR>"]              = "󰌑",
	["<Esc>"]             = "󱊷",
	["<ScrollWheelDown>"] = "󱕐",
	["<ScrollWheelUp>"]   = "󱕑",
	["<NL>"]              = "󰌑",
	["<BS>"]              = "󰁮",
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
	local literal2pattern = function(str)
		return string.gsub(str, "%%", "%%%%")
	end
	local highlight_replacement = function(repl)
		if type(repl) == "string" then
			return literal2pattern(H.highlight(repl, "nofrils-yellow"))
		elseif type(repl) == "function" then
			return
			function(capture)
				local str = repl(capture)
				return literal2pattern(H.highlight(str, "nofrils-yellow"))
			end
		end
	end

local format_visual = function(str)
	for pattern, replacement in pairs(keys) do
		str = string.gsub(str, pattern, highlight_replacement(replacement))
	end
	return str
end

M.macro = function()
	local m = package.loaded["macro"]
	if m then
		local lis = m.get_lis()
		local reg = m.get_reg()

		local lis1 = ""
		for _, i in ipairs(lis) do
			if i == reg then
				lis1 = lis1 .. H.highlight(i, "nofrils-blue-bg")
			else
				lis1 = lis1 .. i
			end
		end

		local macro1 = m.get_macro(reg)
		local macro2 = m.internal2visual(macro1)
		local macro3 = format_visual(macro2)

		return string.format([[(%s "%s")]], lis1, H.truncate(macro3, 8))
	else
		return ""
	end
end
