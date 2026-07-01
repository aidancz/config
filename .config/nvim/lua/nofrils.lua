local M = {}

-- # M.clear

M.clear = function(pattern)
	for name, _ in pairs(vim.api.nvim_get_hl(0, {})) do
	-- https://stackoverflow.com/questions/55108794/what-is-the-difference-between-pairs-and-ipairs-in-lua
		if string.find(name, pattern) then
			vim.api.nvim_set_hl(0, name, {})
		end
	end
end
-- https://www.reddit.com/r/neovim/comments/144bkmu/set_all_highlight_groups_to_the_same_color/

-- # clear existing highlight groups

M.clear(".*")

-- # clear future highlight groups

-- highlight groups can be added later
-- e.g. if you load "mini.test" after this script, the following highlight groups will be added:
-- 	MiniTestEmphasis
-- 	MiniTestFail
-- 	MiniTestPass
-- if you want to clear them, call:
-- 	require("nofrils").clear("^MiniTest")

-- # color palette when `termguicolors` is true

-- local g = {
-- 	color0 = "#2b2b2b", -- for light variant, use "#cdcdcd"
-- 	color1 = "#dc322f",
-- 	color2 = "#859900",
-- 	color3 = "#b58900",
-- 	color4 = "#268bd2",
-- 	color5 = "#d33682",
-- 	color6 = "#2aa198",
-- 	color7 = "#9e9e9e", -- for light variant, use "#525252"
-- }

local g = require("nofrils_x").get_xrdb_color()

-- # define `Normal` highlight group

vim.api.nvim_set_hl(0, "Normal", {ctermbg = 0, ctermfg = 7, bg = g.color0, fg = g.color7})

-- # define basic highlight groups that can be linked later

vim.api.nvim_set_hl(0, "nofrils_black",      {ctermbg = "NONE", ctermfg = 0, bg = "NONE",   fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_red",        {ctermbg = "NONE", ctermfg = 1, bg = "NONE",   fg = g.color1})
vim.api.nvim_set_hl(0, "nofrils_green",      {ctermbg = "NONE", ctermfg = 2, bg = "NONE",   fg = g.color2})
vim.api.nvim_set_hl(0, "nofrils_yellow",     {ctermbg = "NONE", ctermfg = 3, bg = "NONE",   fg = g.color3})
vim.api.nvim_set_hl(0, "nofrils_blue",       {ctermbg = "NONE", ctermfg = 4, bg = "NONE",   fg = g.color4})
vim.api.nvim_set_hl(0, "nofrils_magenta",    {ctermbg = "NONE", ctermfg = 5, bg = "NONE",   fg = g.color5})
vim.api.nvim_set_hl(0, "nofrils_cyan",       {ctermbg = "NONE", ctermfg = 6, bg = "NONE",   fg = g.color6})
vim.api.nvim_set_hl(0, "nofrils_white",      {ctermbg = "NONE", ctermfg = 7, bg = "NONE",   fg = g.color7})
vim.api.nvim_set_hl(0, "nofrils_black_bg",   {ctermbg = 0,      ctermfg = 7, bg = g.color0, fg = g.color7})
vim.api.nvim_set_hl(0, "nofrils_red_bg",     {ctermbg = 1,      ctermfg = 0, bg = g.color1, fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_green_bg",   {ctermbg = 2,      ctermfg = 0, bg = g.color2, fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_yellow_bg",  {ctermbg = 3,      ctermfg = 0, bg = g.color3, fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_blue_bg",    {ctermbg = 4,      ctermfg = 0, bg = g.color4, fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_magenta_bg", {ctermbg = 5,      ctermfg = 0, bg = g.color5, fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_cyan_bg",    {ctermbg = 6,      ctermfg = 0, bg = g.color6, fg = g.color0})
vim.api.nvim_set_hl(0, "nofrils_white_bg",   {ctermbg = 7,      ctermfg = 0, bg = g.color7, fg = g.color0})

vim.api.nvim_set_hl(0, "nofrils_reverse",     {reverse = true})
vim.api.nvim_set_hl(0, "nofrils_transparent", {blend = 100, nocombine = true})
vim.api.nvim_set_hl(0, "nofrils_underline",   {underline = true, sp = g.color7})

-- # define builtin highlight groups
-- for detailed information, run `:h highlight-groups`

-- ## message

vim.api.nvim_set_hl(0, "ErrorMsg",   {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "WarningMsg", {link = "nofrils_yellow"})

-- ## ui chars

vim.api.nvim_set_hl(0, "FloatBorder",  {})
vim.api.nvim_set_hl(0, "WinSeparator", {})

-- ## tabline

vim.api.nvim_set_hl(0, "TabLine",     {})
vim.api.nvim_set_hl(0, "TabLineFill", {})
vim.api.nvim_set_hl(0, "TabLineSel",  {link = "nofrils_reverse"})

-- ## statusline

vim.api.nvim_set_hl(0, "StatusLine", {})

-- ## statuscolumn

vim.api.nvim_set_hl(0, "LineNr",      {})
vim.api.nvim_set_hl(0, "LineNrAbove", {})
vim.api.nvim_set_hl(0, "LineNrBelow", {})

-- ## together with `guicursor`, controls cursor color

vim.api.nvim_set_hl(0, "Cursor",     {})
vim.api.nvim_set_hl(0, "lCursor",    {})
vim.api.nvim_set_hl(0, "TermCursor", {})

-- ## cursorline/cursorcolumn

vim.api.nvim_set_hl(0, "CursorLine",     {link = "nofrils_reverse"})
vim.api.nvim_set_hl(0, "CursorLineFold", {})
vim.api.nvim_set_hl(0, "CursorLineSign", {})
vim.api.nvim_set_hl(0, "CursorLineNr",   {}) -- conflict with "statuscolumn"
vim.api.nvim_set_hl(0, "QuickFixLine",   {})
vim.api.nvim_set_hl(0, "CursorColumn",   {link = "nofrils_reverse"})

-- ## buffer content

vim.api.nvim_set_hl(0, "Folded",     {link = "nofrils_yellow_bg"})
vim.api.nvim_set_hl(0, "MatchParen", {link = "nofrils_yellow_bg"})
vim.api.nvim_set_hl(0, "NonText",    {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "SpecialKey", {link = "nofrils_yellow_bg"})
vim.api.nvim_set_hl(0, "Whitespace", {link = "nofrils_yellow"})

-- ## search

vim.api.nvim_set_hl(0, "Search",    {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "CurSearch", {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "IncSearch", {link = "nofrils_white_bg"})

-- ## visual

vim.api.nvim_set_hl(0, "Visual", {link = "nofrils_blue_bg"})

-- ## menu

vim.api.nvim_set_hl(0, "Pmenu",      {})
vim.api.nvim_set_hl(0, "PmenuSbar",  {})
vim.api.nvim_set_hl(0, "PmenuSel",   {link = "nofrils_reverse"})
vim.api.nvim_set_hl(0, "PmenuThumb", {link = "nofrils_reverse"})

-- ## diff

vim.api.nvim_set_hl(0, "DiffAdd",    {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "DiffChange", {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiffDelete", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiffText",   {link = "nofrils_blue"})

-- # define syntax highlight groups
-- for detailed information, run `:h group-name`

vim.api.nvim_set_hl(0, "Added",   {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "Changed", {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "Comment", {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "Error",   {link = "nofrils_red_bg"})
vim.api.nvim_set_hl(0, "Removed", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "Special", {link = "nofrils_magenta"})

-- # return

return M
