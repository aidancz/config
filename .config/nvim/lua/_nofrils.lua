-- https://github.com/echasnovski/mini.nvim/issues/1326

-- require("mini.deps").add({
-- 	source = "aidancz/nofrils.nvim",
-- })

----------------------------------------------------------------

local main = function()

-- # set option

vim.opt.background = "dark"

-- # clear definition of all existing highlight groups

require("nofrils").clear(".*")

-- # get xresources colors and store them in a table named `x`

local x = require("nofrils").get_xresources()

-- # define basic highlight groups that can be linked later

vim.api.nvim_set_hl(0, "nofrils_black",      {ctermbg = "NONE", ctermfg = 0, bg = "NONE",   fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_red",        {ctermbg = "NONE", ctermfg = 1, bg = "NONE",   fg = x.color1})
vim.api.nvim_set_hl(0, "nofrils_green",      {ctermbg = "NONE", ctermfg = 2, bg = "NONE",   fg = x.color2})
vim.api.nvim_set_hl(0, "nofrils_yellow",     {ctermbg = "NONE", ctermfg = 3, bg = "NONE",   fg = x.color3})
vim.api.nvim_set_hl(0, "nofrils_blue",       {ctermbg = "NONE", ctermfg = 4, bg = "NONE",   fg = x.color4})
vim.api.nvim_set_hl(0, "nofrils_magenta",    {ctermbg = "NONE", ctermfg = 5, bg = "NONE",   fg = x.color5})
vim.api.nvim_set_hl(0, "nofrils_cyan",       {ctermbg = "NONE", ctermfg = 6, bg = "NONE",   fg = x.color6})
vim.api.nvim_set_hl(0, "nofrils_white",      {ctermbg = "NONE", ctermfg = 7, bg = "NONE",   fg = x.color7})
vim.api.nvim_set_hl(0, "nofrils_black_bg",   {ctermbg = "NONE", ctermfg = 0, bg = "NONE",   fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_red_bg",     {ctermbg = 1,      ctermfg = 0, bg = x.color1, fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_green_bg",   {ctermbg = 2,      ctermfg = 0, bg = x.color2, fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_yellow_bg",  {ctermbg = 3,      ctermfg = 0, bg = x.color3, fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_blue_bg",    {ctermbg = 4,      ctermfg = 0, bg = x.color4, fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_magenta_bg", {ctermbg = 5,      ctermfg = 0, bg = x.color5, fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_cyan_bg",    {ctermbg = 6,      ctermfg = 0, bg = x.color6, fg = x.color0})
vim.api.nvim_set_hl(0, "nofrils_white_bg",   {ctermbg = 7,      ctermfg = 0, bg = x.color7, fg = x.color0})

vim.api.nvim_set_hl(0, "nofrils_gray",    {ctermbg = 0,   ctermfg = 244, bg = "#808080", fg = "#808080"})
vim.api.nvim_set_hl(0, "nofrils_gray_bg", {ctermbg = 244, ctermfg = 0,   bg = "#808080", fg = "#808080"})

vim.api.nvim_set_hl(0, "nofrils_reverse",     {reverse = true})
vim.api.nvim_set_hl(0, "nofrils_transparent", {blend = 100, nocombine = true})

-- # define `Normal` highlight group

vim.api.nvim_set_hl(0, "Normal", {ctermbg = 0, ctermfg = 7, bg = x.color0, fg = x.color7})

-- # define highlight groups
-- for detailed information, run `:h highlight-groups`

vim.api.nvim_set_hl(0, "CurSearch",    {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "Cursor",       {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "CursorColumn", {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "CursorLine",   {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "DiffAdd",      {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "DiffChange",   {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiffDelete",   {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiffText",     {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "ErrorMsg",     {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "FloatBorder",  {})
vim.api.nvim_set_hl(0, "Folded",       {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "IncSearch",    {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "LineNr",       {link = "nofrils_white"})
vim.api.nvim_set_hl(0, "LineNrAbove",  {link = "nofrils_white"})
vim.api.nvim_set_hl(0, "LineNrBelow",  {link = "nofrils_white"})
vim.api.nvim_set_hl(0, "MatchParen",   {link = "nofrils_yellow_bg"})
vim.api.nvim_set_hl(0, "NonText",      {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "Pmenu",        {})
vim.api.nvim_set_hl(0, "PmenuSbar",    {})
vim.api.nvim_set_hl(0, "PmenuSel",     {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "PmenuThumb",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "QuickFixLine", {})
vim.api.nvim_set_hl(0, "Search",       {link = "nofrils_green_bg"})
vim.api.nvim_set_hl(0, "SpecialKey",   {link = "nofrils_yellow_bg"})
vim.api.nvim_set_hl(0, "StatusLine",   {link = "nofrils_white"})
vim.api.nvim_set_hl(0, "TabLine",      {})
vim.api.nvim_set_hl(0, "TabLineFill",  {})
vim.api.nvim_set_hl(0, "TabLineSel",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "TermCursor",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "Visual",       {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "WarningMsg",   {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "Whitespace",   {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "WinSeparator", {})

-- # define highlight groups
-- for detailed information, run `:h group-name`

vim.api.nvim_set_hl(0, "Added",   {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "Changed", {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "Comment", {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "Error",   {link = "nofrils_red_bg"})
vim.api.nvim_set_hl(0, "Removed", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "Special", {link = "nofrils_magenta"})

-- # define highlight groups
-- for detailed information, run `:e $VIMRUNTIME/lua/man.lua`

vim.api.nvim_set_hl(0, "manBold",      {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "manItalic",    {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "manUnderline", {link = "nofrils_cyan"})

end

----------------------------------------------------------------

require("nofrils").setup({
	path_xresources = os.getenv("HOME") .. "/.Xresources",
	main = main,
})

----------------------------------------------------------------

vim.cmd("colorscheme nofrils")
-- `ColorScheme` autocmd will be triggered
