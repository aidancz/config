-- # $VIMRUNTIME/filetype.vim $VIMRUNTIME/filetype.lua

vim.cmd([[
filetype on
]])

-- # $VIMRUNTIME/ftplugin/*

--[[
it's possible to turn off specific filetype plugin

e.g. turn off markdown filetype plugin:

```
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1
```

save the text above as ~/.config/nvim/ftplugin/markdown.vim
this will turn off markdown filetype plugin,
which located at $VIMRUNTIME/ftplugin/markdown.vim
--]]

vim.cmd([[
filetype plugin off
]])

-- # $VIMRUNTIME/indent/*

vim.cmd([[
filetype indent off
]])

-- # $VIMRUNTIME/syntax/*

vim.cmd([[
syntax off
]])

-- # $VIMRUNTIME/plugin/*

-- lazy.nvim search "disabled_plugins"

vim.g.loaded_gzip              = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin         = 1

-- vim.g.loaded_man               = 1
-- vim.g.loaded_shada_plugin      = 1
-- vim.g.loaded_spellfile_plugin  = 1
-- vim.g.loaded_remote_plugins    = 1

-- # $VIMRUNTIME/lua/vim/_defaults.lua

-- `:h default-mappings`

vim.cmd([[
mapclear
]])
