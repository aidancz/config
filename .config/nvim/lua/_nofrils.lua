-- https://github.com/echasnovski/mini.nvim/issues/1326

vim.opt.runtimepath:prepend("~/sync_git/nofrils.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/nofrils.nvim",
-- })

----------------------------------------------------------------

local main = function()

-- # set option

vim.opt.background = "dark"



-- # clear definition of all existing highlight groups

require("nofrils").clear({".*"})



-- # get xresources colors and store them in a table named `x`

local x = require("nofrils").get_xresources()



-- # define basic highlight groups that can be linked later

vim.api.nvim_set_hl(0, 'nofrils-black',      {ctermbg = 'NONE', ctermfg = 0, bg = 'NONE',   fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-red',        {ctermbg = 'NONE', ctermfg = 1, bg = 'NONE',   fg = x.color1})
vim.api.nvim_set_hl(0, 'nofrils-green',      {ctermbg = 'NONE', ctermfg = 2, bg = 'NONE',   fg = x.color2})
vim.api.nvim_set_hl(0, 'nofrils-yellow',     {ctermbg = 'NONE', ctermfg = 3, bg = 'NONE',   fg = x.color3})
vim.api.nvim_set_hl(0, 'nofrils-blue',       {ctermbg = 'NONE', ctermfg = 4, bg = 'NONE',   fg = x.color4})
vim.api.nvim_set_hl(0, 'nofrils-magenta',    {ctermbg = 'NONE', ctermfg = 5, bg = 'NONE',   fg = x.color5})
vim.api.nvim_set_hl(0, 'nofrils-cyan',       {ctermbg = 'NONE', ctermfg = 6, bg = 'NONE',   fg = x.color6})
vim.api.nvim_set_hl(0, 'nofrils-white',      {ctermbg = 'NONE', ctermfg = 7, bg = 'NONE',   fg = x.color7})
vim.api.nvim_set_hl(0, 'nofrils-black-bg',   {ctermbg = 'NONE', ctermfg = 0, bg = 'NONE',   fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-red-bg',     {ctermbg = 1,      ctermfg = 0, bg = x.color1, fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-green-bg',   {ctermbg = 2,      ctermfg = 0, bg = x.color2, fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-yellow-bg',  {ctermbg = 3,      ctermfg = 0, bg = x.color3, fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-blue-bg',    {ctermbg = 4,      ctermfg = 0, bg = x.color4, fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-magenta-bg', {ctermbg = 5,      ctermfg = 0, bg = x.color5, fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-cyan-bg',    {ctermbg = 6,      ctermfg = 0, bg = x.color6, fg = x.color0})
vim.api.nvim_set_hl(0, 'nofrils-white-bg',   {ctermbg = 7,      ctermfg = 0, bg = x.color7, fg = x.color0})

vim.api.nvim_set_hl(0, 'nofrils-gray',    {ctermbg = 0,   ctermfg = 244, bg = '#808080', fg = '#808080'})
vim.api.nvim_set_hl(0, 'nofrils-gray-bg', {ctermbg = 244, ctermfg = 0,   bg = '#808080', fg = '#808080'})

vim.api.nvim_set_hl(0, 'nofrils-reverse', {reverse = true})



-- # define `Normal` highlight group

vim.api.nvim_set_hl(0, 'Normal', {ctermbg = 0, ctermfg = 7, bg = x.color0, fg = x.color7})



-- # define highlight groups
-- for detailed information, run `:h highlight-groups`

vim.api.nvim_set_hl(0, 'Whitespace',   {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, 'SpecialKey',   {link = 'nofrils-yellow-bg'})
vim.api.nvim_set_hl(0, 'NonText',      {link = 'nofrils-yellow'})

vim.api.nvim_set_hl(0, 'Cursor',       {link = 'nofrils-white-bg'})
vim.api.nvim_set_hl(0, 'TermCursor',   {link = 'nofrils-white-bg'})
vim.api.nvim_set_hl(0, 'Visual',       {link = 'nofrils-blue-bg'})
vim.api.nvim_set_hl(0, 'CursorLine',   {link = 'nofrils-blue-bg'})
vim.api.nvim_set_hl(0, 'CursorColumn', {link = 'nofrils-blue-bg'})
vim.api.nvim_set_hl(0, 'MatchParen',   {link = 'nofrils-yellow-bg'})

vim.api.nvim_set_hl(0, 'DiffAdd',      {link = 'nofrils-green'})
vim.api.nvim_set_hl(0, 'DiffChange',   {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, 'DiffDelete',   {link = 'nofrils-red'})
vim.api.nvim_set_hl(0, 'DiffText',     {link = 'nofrils-blue'})

vim.api.nvim_set_hl(0, 'Search',       {link = 'nofrils-green-bg'})
vim.api.nvim_set_hl(0, 'CurSearch',    {link = 'nofrils-blue-bg'})
vim.api.nvim_set_hl(0, 'IncSearch',    {link = 'nofrils-blue-bg'})

vim.api.nvim_set_hl(0, 'LineNr',       {link = 'nofrils-white'})
vim.api.nvim_set_hl(0, 'LineNrAbove',  {link = 'nofrils-white'})
vim.api.nvim_set_hl(0, 'LineNrBelow',  {link = 'nofrils-white'})

vim.api.nvim_set_hl(0, 'Pmenu',        {})
vim.api.nvim_set_hl(0, 'PmenuSel',     {link = 'nofrils-white-bg'})
vim.api.nvim_set_hl(0, 'PmenuSbar',    {})
vim.api.nvim_set_hl(0, 'PmenuThumb',   {link = 'nofrils-white-bg'})
vim.api.nvim_set_hl(0, 'StatusLine',   {link = 'nofrils-white'})

vim.api.nvim_set_hl(0, 'FloatBorder',  {})
vim.api.nvim_set_hl(0, 'WinSeparator', {})

vim.api.nvim_set_hl(0, 'WarningMsg',   {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, 'ErrorMsg',     {link = 'nofrils-red'})

vim.api.nvim_set_hl(0, 'Folded',       {link = 'nofrils-yellow'})



-- # define highlight groups
-- for detailed information, run `:h group-name`

vim.api.nvim_set_hl(0, 'Comment', {link = 'nofrils-blue'})
vim.api.nvim_set_hl(0, 'Error',   {link = 'nofrils-red-bg'})
vim.api.nvim_set_hl(0, 'Added',   {link = 'nofrils-green'})
vim.api.nvim_set_hl(0, 'Changed', {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, 'Removed', {link = 'nofrils-red'})



-- # define highlight groups
-- for detailed information, run `:e $VIMRUNTIME/lua/man.lua`

vim.api.nvim_set_hl(0, 'manBold',      {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, 'manItalic',    {link = 'nofrils-blue'})
vim.api.nvim_set_hl(0, 'manUnderline', {link = 'nofrils-cyan'})

end

----------------------------------------------------------------

require("nofrils").setup({
	path_xresources = os.getenv('HOME') .. '/.Xresources',
	main = main,
})

----------------------------------------------------------------

vim.cmd("colorscheme nofrils")
-- `ColorScheme` autocmd will be triggered
