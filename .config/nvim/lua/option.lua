-- # leader key

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<space>")

-- # appearance

-- ## true color

vim.o.termguicolors = true

-- ## message

vim.o.shortmess = ""
vim.opt.shortmess:append("I")
-- no intro message when starting vim
vim.opt.shortmess:append("F")
-- no file message when editing a file
vim.opt.shortmess:remove("S")
-- show search count, e.g. [1/5]

vim.o.showmode = false
-- show "-- INSERT --" when switching to insert mode, etc

vim.o.showcmd = true
-- show z when using zz, etc, show size of selection when in visual mode
vim.o.showcmdloc = "last"

-- ## ui chars

vim.o.winborder = "bold"

vim.o.fillchars = ""

vim.opt.fillchars:append({eob       = " "})
-- virtual lines at the end of a buffer, default: ~

vim.opt.fillchars:append({fold      = " "})
vim.opt.fillchars:append({foldclose = "●"})
vim.opt.fillchars:append({foldopen  = "○"})
vim.opt.fillchars:append({foldsep   = "1"})

vim.opt.fillchars:append({horiz     = "━"})
vim.opt.fillchars:append({horizdown = "┳"})
vim.opt.fillchars:append({horizup   = "┻"})
vim.opt.fillchars:append({vert      = "┃"})
vim.opt.fillchars:append({verthoriz = "╋"})
vim.opt.fillchars:append({vertleft  = "┫"})
vim.opt.fillchars:append({vertright = "┣"})

-- vim.opt.fillchars:append({horiz     = "-"})
-- vim.opt.fillchars:append({horizdown = "-"})
-- vim.opt.fillchars:append({horizup   = "-"})
-- vim.opt.fillchars:append({vert      = "|"})
-- vim.opt.fillchars:append({verthoriz = "+"})
-- vim.opt.fillchars:append({vertleft  = "|"})
-- vim.opt.fillchars:append({vertright = "|"})

vim.opt.fillchars:append({msgsep    = "━"})

-- ## cmdline

vim.o.cmdheight = 1
vim.o.cmdwinheight = 8

-- ## statusline

vim.o.laststatus = 3

-- ## statuscolumn

vim.o.statuscolumn = ""

vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.o.foldlevel = 0
vim.o.foldlevelstart = 0
vim.o.foldmethod = "marker"
vim.o.foldtext = ""

vim.o.signcolumn = "yes:2"
-- https://github.com/neovim/neovim/issues/10106
-- https://github.com/neovim/neovim/issues/13098

vim.o.numberwidth = 3
vim.o.number = false
vim.o.relativenumber = true

-- ## cursor

vim.o.guicursor = ""

-- vim.o.guicursor = "a:nofrils_red_bg"
-- vim.api.nvim_create_augroup("option_fix_guicursor", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	"FocusGained",
-- 	{
-- 		group = "option_fix_guicursor",
-- 		callback = function()
-- 			vim.o.guicursor = "a:nofrils_red_bg"
-- 		end,
-- 	}
-- )
-- vim.api.nvim_create_autocmd(
-- 	"VimLeave",
-- 	{
-- 		group = "option_fix_guicursor",
-- 		callback = function()
-- 			vim.o.guicursor = "a:nofrils_white_bg"
-- 		end,
-- 	}
-- )

-- vim.o.cursorline = true
-- vim.o.cursorlineopt = "screenline"
-- vim.api.nvim_create_augroup("option_fix_cursorline", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	"WinEnter",
-- 	{
-- 		group = "option_fix_cursorline",
-- 		callback = function()
-- 			vim.wo.cursorline = true
-- 		end,
-- 	}
-- )
-- vim.api.nvim_create_autocmd(
-- 	"WinLeave",
-- 	{
-- 		group = "option_fix_cursorline",
-- 		callback = function()
-- 			vim.wo.cursorline = false
-- 		end,
-- 	}
-- )
-- -- https://stackoverflow.com/questions/12017331/how-can-i-make-vim-highlight-the-current-line-on-only-the-active-buffer

vim.o.cursorcolumn = false

-- ## buffer content

vim.o.list = true
vim.o.listchars = ""
-- vim.opt.listchars:append({eol = " "})
-- NOTE: https://github.com/neovim/neovim/issues/7928
-- NOTE: https://github.com/neovim/neovim/issues/32556
-- NOTE: https://github.com/neovim/neovim/issues/33080
vim.opt.listchars:append({tab = "  "})
-- NOTE: https://vi.stackexchange.com/questions/2239/how-can-i-make-vim-position-the-cursor-at-the-start-of-a-tab-character-instead-o
vim.opt.listchars:append({nbsp = "▪"})

-- some unicode symbols: ·▫░▒▓█

vim.o.display = "lastline"
-- show @@@ at the end when a line cannot be fully displayed

vim.o.concealcursor = ""
vim.o.conceallevel = 0

-- # navigation

-- ## cursor

-- vim.o.virtualedit = "none"

vim.o.virtualedit = "onemore"

vim.api.nvim_create_augroup("option_fix_virtualedit", {clear = true})
vim.api.nvim_create_autocmd(
	"InsertLeave",
	{
		group = "option_fix_virtualedit",
		callback = function()
			local pos = vim.api.nvim_buf_get_mark(0, "^")
			vim.api.nvim_win_set_cursor(0, pos)
		end,
	}
)

--[[
vi evilly hide 2 things:

1. eol
eol is the LF char, ascii 10
vi hide LF if the char before is not LF

2. eob
eob is not a real char, but a position that allows cursor to be placed at even if there is no char at all
vi hide this position if a buffer has any char

but keeping this position visible ensures consistency
emacs keeps this position
helix keeps this position and denotes it in line number column

due to this lack of foresight in the design, many problems have arisen

one of the problems is:
when leaving insert mode, cursor has to move back one position to the left
since there is no eol/eob to land on!

i am the person cares about consistency
"maybe i could fix this", i thought, so:

```vim
set virtualedit=onemore
set listchars+=eol:\ ,
autocmd InsertLeave * :normal! `^
```

works great!
but later, more inconsistency is discovered:
normal mode $ does not take you to the fake eol
normal mode x does not delete the fake eol
when a line's width is equal to the screen's width, with/without listchars, the behavior of gj/gk is confusing
...
this list is endless, just search "virutaledit" in the github issue page

the whole vim is built with the assumption of hiding eol and eob
trying to break this assumption makes so many things misbehave

but some things work:
- vim.fn.col works perfectly
- vim.fn.virtcol("$") and vim.fn.virtcol({lnum, "$"}) works perfectly
  though the doc says: "the result is the number of cells in the cursor line plus one"
  come on! why just say: "the result is eol's virtcol"?
  this remind me of the doc about "inclusive" and "exclusive", which says "the last character towards the end of the buffer is not included"
  come on! why just say: "inclusive treats cursor as block, while exclusive treats cursor as bar"?

luckily, some improvement was made:
- the "selection" option fix the eol problem in visual mode

so "vim.o.virtualedit = onemore" is acceptable
but definitely DO NOT use "vim.o.virtualedit = all", that will break so many things

related:
https://github.com/neovim/neovim/issues/6415
https://github.com/neovim/neovim/issues/37575
--]]

vim.o.startofline = false
vim.o.jumpoptions = "stack,view"
vim.o.whichwrap = ""
vim.o.matchpairs = "(:),{:},[:],<:>"

-- ## search

vim.o.hlsearch = false
vim.o.incsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.magic = true

-- ## scroll

vim.o.scrolloff = 0
vim.o.smoothscroll = true

-- ## mouse

vim.o.mouse = "a"
vim.o.mousemodel = "popup_setpos"

-- # edit

-- ## copy & paste

vim.o.clipboard = "unnamed,unnamedplus"

-- ## undo

vim.o.undofile = true
vim.o.undolevels = 1024

-- ## auto linebreak

vim.o.textwidth = 0
vim.o.wrapmargin = 0

vim.o.formatoptions = ""
-- https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

-- ## indent

vim.o.tabstop = 8
-- ? column of whitespace \t worth
vim.o.softtabstop = 0
-- ? column of whitespace <tab>/<bs> worth, 0 turns off this feature
vim.o.shiftwidth = 8
-- ? column of whitespace >>/<< worth

-- we abbreviate "? column of whitespace" as "indent" from now on
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

vim.o.expandtab = false
-- input " " instead of "\t"?

vim.o.autoindent = false
-- when create a new line, copy indent from the line above?
vim.o.copyindent = true
-- when autoindent is true, when create a new line, copy indent (use same whitespace chars) from the line above?

-- let's say we have "▫▫▫·alice and bob", and press "o" (▫ is space, · is tab, █ is cursor)
-- autoindent = true, copyindent = false:
-- ▫▫▫·alice and bob
-- ·▫▫▫█
-- autoindent = true, copyindent = true:
-- ▫▫▫·alice and bob
-- ▫▫▫·█

vim.o.smarttab = false
-- at line start, when use <tab>, use shiftwidth instead of softtabstop
vim.o.preserveindent = false
-- at line start, when use >>/<<, preserve current indent
-- let's say we have "▫▫▫·alice and bob", and press ">>"
-- preserveindent = true:
-- ▫▫▫·alice and bob
-- ▫▫▫··alice and bob

vim.o.shiftround = true

vim.o.indentkeys = ""

-- # mode specific

-- ## x

vim.o.selection = "inclusive"

-- ## i

vim.o.showmatch = true
vim.o.matchtime = 1

vim.o.backspace = "indent,eol,nostop"

vim.o.completeopt = "menu,preview"

-- ## c

vim.o.wildmenu = true
-- using wildchar (usually <tab>) to perform a command-line completion, shows a menu

vim.o.wildoptions = "pum,tagfile"
-- pum: popup menu

vim.o.inccommand = ""

-- # language specific

vim.o.iskeyword = "a-z,A-Z,48-57"

vim.o.commentstring = "#%s"

-- # buffer window tab

-- ## buffer

vim.o.hidden = true

-- ## window

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "topline"
vim.o.equalalways = true
vim.o.winfixheight = false

-- # file dir

-- ## file

vim.o.autoread = true
vim.o.autowrite = true

-- ## dir

vim.o.autochdir = true

-- # editor

-- ## updatetime

vim.o.updatetime = 100
-- https://github.com/iamcco/markdown-preview.nvim/issues/4

-- ## keypress timeout

vim.o.timeout = false
vim.o.timeoutlen = 8
-- key timeout, e.g. zz

vim.o.ttimeout = true
vim.o.ttimeoutlen = 0
-- keycode timeout, e.g. ^[j
-- in terminal, press <a-j> or <esc>j send the same keycode "^[j" to program
-- if you are vim, when you receive keycode "^[", you can choose wait or not

-- ## messagesopt

vim.o.messagesopt = "hit-enter,history:1024"

-- # cpoptions

vim.o.cpoptions = vim.o.cpoptions
-- use default flags

vim.opt.cpoptions:remove("_")
-- https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing

-- vim.opt.cpoptions:append("$")
-- $ at the end of the changed text

-- vim.opt.cpoptions:append("v")
-- visible backspaced chars

-- vim.opt.cpoptions:append("u")
-- undo
