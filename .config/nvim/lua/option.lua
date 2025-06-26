----------------------------------------------------------------

-- vim.opt.commentstring = "#%s"
-- vim.opt.cpoptions:append("$")
-- vim.opt.cpoptions:append("u")
-- vim.opt.cpoptions:append("v")
-- vim.opt.cursorline = true
-- vim.opt.fillchars:append({horiz     = "-"})
-- vim.opt.fillchars:append({horizdown = "-"})
-- vim.opt.fillchars:append({horizup   = "-"})
-- vim.opt.fillchars:append({vert      = "|"})
-- vim.opt.fillchars:append({verthoriz = "+"})
-- vim.opt.fillchars:append({vertleft  = "|"})
-- vim.opt.fillchars:append({vertright = "|"})
-- vim.opt.iskeyword:append("-")
-- vim.opt.iskeyword:append("_")
-- vim.opt.listchars:append({trail = "#"})
-- vim.opt.messagesopt = {"wait:0", "history:512"}
-- vim.opt.splitkeep = "topline"
vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backspace = {"indent", "eol", "start", "nostop"}
vim.opt.clipboard:prepend("unnamed")
vim.opt.clipboard:prepend("unnamedplus")
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 8
vim.opt.completeopt = {"menu", "preview"}
vim.opt.concealcursor = ""
vim.opt.conceallevel = 0
vim.opt.copyindent = true
vim.opt.cpoptions:remove("_")
vim.opt.display = "lastline"
vim.opt.equalalways = true
vim.opt.expandtab = false
vim.opt.fillchars = ""
vim.opt.fillchars:append({eob       = " "})
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
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0
vim.opt.foldmethod = "marker"
vim.opt.foldtext = ""
vim.opt.formatoptions = ""
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = ""
vim.opt.incsearch = false
vim.opt.indentkeys = ""
vim.opt.iskeyword:remove("_")
vim.opt.jumpoptions = {"stack", "view"}
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = ""
vim.opt.listchars:append({eol = " "})
vim.opt.listchars:append({nbsp = "▪"})
vim.opt.listchars:append({tab = "  "})
vim.opt.magic = true
vim.opt.matchpairs:append("<:>")
vim.opt.matchtime = 1
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"
vim.opt.number = false
vim.opt.numberwidth = 3
vim.opt.preserveindent = false
vim.opt.relativenumber = true
vim.opt.scrolloff = 0
vim.opt.selection = "inclusive"
vim.opt.shiftround = true
vim.opt.shiftwidth = 8
vim.opt.shortmess:append("I")
vim.opt.shortmess:remove("S")
vim.opt.showcmd = true
vim.opt.showcmdloc = "last"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes:2"
vim.opt.smartcase = true
vim.opt.smarttab = false
vim.opt.smoothscroll = true
vim.opt.softtabstop = 0
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.statuscolumn = ""
vim.opt.tabstop = 8
vim.opt.termguicolors = true
vim.opt.textwidth = 0
vim.opt.timeout = false
vim.opt.timeoutlen = 8
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0
vim.opt.undofile = true
vim.opt.undolevels = 1024
vim.opt.updatetime = 100
vim.opt.virtualedit = "onemore"
vim.opt.whichwrap:append("[,]")
vim.opt.wildmenu = true
vim.opt.wildoptions = {"pum", "tagfile"}
vim.opt.winborder = "bold"
vim.opt.winfixheight = false
vim.opt.wrapmargin = 0

----------------------------------------------------------------

-- # autoindent copyindent
-- autoindent: when create a new line, copy indent from the line above
-- copyindent: based on "autoindent", when create a new line, copy indent (use same whitespace chars) from the line above
-- let's say we have "▫▫▫·alice and bob", and press "o" (▫ space · tab █ cursor)
-- "set autoindent nocopyindent": "·▫▫▫█"
-- "set autoindent copyindent":   "▫▫▫·█"

-- # cpoptions
-- https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing

-- # expandtab
-- replace "\t" with " "

-- # formatoptions
-- https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

-- # listchars
-- https://vi.stackexchange.com/questions/2239/how-can-i-make-vim-position-the-cursor-at-the-start-of-a-tab-character-instead-o
-- some unicode symbols (to keep these chars' original color, we wrap them in a variable):
local comment = [[·▫░▒▓█]]
-- use "ga" to get the code point

-- # preserveindent
-- at line start, when use >>/<<, preserve current indent
-- let's say we have "▫▫▫·alice and bob", and press ">>"
-- "set preserveindent": "▫▫▫··alice and bob"

-- # shortmess
-- set message form

-- # showcmd
-- show z when using zz, etc, show size of selection when in visual mode

-- # showmode
-- show "-- INSERT --" when switching to insert mode, etc

-- # signcolumn
-- https://github.com/neovim/neovim/issues/10106
-- https://github.com/neovim/neovim/issues/13098

-- # smarttab
-- at line start, when use <tab>, use shiftwidth instead of softtabstop

-- # tabstop softtabstop shiftwidth
-- tabstop:     ? column of whitespace \t worth
-- softtabstop: ? column of whitespace <tab>/<bs> worth, 0 turns off this feature
-- shiftwidth:  ? column of whitespace >>/<< worth
-- we abbreviate "? column of whitespace" as "indent" from now on
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

-- # timeout ttimeout
-- in terminal, press <a-j> or <esc>j send the same keycode "^[j" to program
-- if you are vim, when you receive keycode "^[", you can choose wait or not
-- timeout:  whether "^[j and zz" timeout
-- ttimeout: whether "^[j" timeout, t means terminal

-- # updatetime
-- https://github.com/iamcco/markdown-preview.nvim/issues/4

-- # wildmenu
-- using wildchar (usually <tab>) to perform a command-line completion, shows a menu

-- # wildoptions
-- pum: popup menu

----------------------------------------------------------------
