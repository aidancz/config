-- # appearance

vim.opt.termguicolors = true

vim.opt.statuscolumn = ""

vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldtext = ""
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0
vim.opt.foldmethod = "marker"

vim.opt.signcolumn = "yes:4"
-- vim.opt.signcolumn = "yes:2"
-- https://github.com/neovim/neovim/issues/13098
-- https://github.com/neovim/neovim/issues/10106

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 7

vim.opt.guicursor = ""
-- vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.wildoptions = {"pum", "tagfile"}
vim.opt.shortmess:remove("S")
vim.opt.shortmess:append("I")
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"
-- wildmenu	using wildchar (usually <tab>) to perform a command-line completion, shows a menu
-- wildoptions	pum: popup menu
-- shortmess	set message form
-- showmode	show "-- INSERT --" when switching to insert mode, etc
-- showcmd	show z when using zz, etc, show size of selection when in visual mode

vim.opt.list = true
vim.opt.listchars = ""
-- vim.opt.listchars:append({eol = "$"})
vim.opt.listchars:append({tab = "  "})
-- vim.opt.listchars:append({trail = "#"})
vim.opt.listchars:append({nbsp = "▪"})
-- https://vi.stackexchange.com/questions/2239/how-can-i-make-vim-position-the-cursor-at-the-start-of-a-tab-character-instead-o

-- some unicode symbols (to keep these chars' original color, we wrap them in a variable):
local comment = [[·▫░▒▓█]]
-- use "ga" to get the code point

vim.opt.display = {"lastline"}

vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

vim.opt.fillchars = ""

vim.opt.fillchars:append({eob       = " "})
vim.opt.fillchars:append({fold      = " "})
vim.opt.fillchars:append({foldclose = "●"})
vim.opt.fillchars:append({foldopen  = "○"})
vim.opt.fillchars:append({foldsep   = "1"})

-- vim.opt.fillchars:append({horiz     = "-"})
-- vim.opt.fillchars:append({horizup   = "-"})
-- vim.opt.fillchars:append({horizdown = "-"})
-- vim.opt.fillchars:append({vert      = "|"})
-- vim.opt.fillchars:append({vertleft  = "|"})
-- vim.opt.fillchars:append({vertright = "|"})
-- vim.opt.fillchars:append({verthoriz = "+"})

vim.opt.fillchars:append({horiz     = "━"})
vim.opt.fillchars:append({horizup   = "┻"})
vim.opt.fillchars:append({horizdown = "┳"})
vim.opt.fillchars:append({vert      = "┃"})
vim.opt.fillchars:append({vertleft  = "┫"})
vim.opt.fillchars:append({vertright = "┣"})
vim.opt.fillchars:append({verthoriz = "╋"})



-- # navigation

vim.opt.virtualedit = {"onemore"}
vim.opt.startofline = false
vim.opt.jumpoptions = {"stack", "view"}
vim.opt.scrolloff = 0
vim.opt.whichwrap:append("[,]")
vim.opt.iskeyword:remove("_")
-- vim.opt.iskeyword:append("_")
-- vim.opt.iskeyword:append("-")
vim.opt.smoothscroll = true

vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"



-- # keypress timeout

vim.opt.timeout = false
vim.opt.timeoutlen = 8
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0
-- in terminal, press <a-j> or <esc>j send the same keycode "^[j" to program
-- if you are vim, when you receive keycode "^[", you can choose wait or not
-- timeout	whether "^[j and zz" timeout
-- ttimeout	whether "^[j" timeout, t means terminal



-- # search & substitute

vim.opt.hlsearch = false
vim.opt.incsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true

vim.opt.inccommand = ""



-- # copy & paste

vim.opt.clipboard:prepend({"unnamed"})
vim.opt.clipboard:prepend({"unnamedplus"})



-- # indent

vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 8
-- tabstop	? column of whitespace \t worth
-- softtabstop	? column of whitespace <tab>/<bs> worth, 0 turns off this feature
-- shiftwidth	? column of whitespace >>/<< worth
-- we abbreviate "? column of whitespace" as "indent" from now on
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

vim.opt.expandtab = false
-- expandtab	replace "\t" with " "

vim.opt.autoindent = true
vim.opt.copyindent = true
-- autoindent	when create a new line, copy indent from the line above
-- copyindent	based on "autoindent", when create a new line, copy indent (use same whitespace chars) from the line above
-- let's say we have "▫▫▫·alice and bob", and press "o" (▫ space · tab █ cursor)
-- "autoindent": "·▫▫▫█"
-- "autoindent" & "copyindent": "▫▫▫·█"

vim.opt.smarttab = false
vim.opt.preserveindent = false
vim.opt.shiftround = true
-- smarttab		at line start, when use <tab>, use shiftwidth instead of softtabstop
-- preserveindent	at line start, when use >>/<<, preserve current indent
-- let's say we have "▫▫▫·alice and bob", and press ">>"
-- "preserveindent": "▫▫▫··alice and bob"



-- # match pair

vim.opt.matchpairs:append("<:>")
vim.opt.showmatch = true
vim.opt.matchtime = 1



-- # auto linebreak

vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

vim.opt.formatoptions = ""
-- https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines



-- # undo

vim.opt.undofile = true
vim.opt.undolevels = 1024



-- # buffer window tab

vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.splitkeep = "topline"
vim.opt.equalalways = true
vim.opt.winfixheight = false
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 8
vim.opt.laststatus = 2
-- https://github.com/neovim/neovim/issues/18965



-- # misc

vim.opt.cpoptions:remove("_")
vim.opt.cpoptions:append("u")
-- vim.opt.cpoptions:append("v")
-- vim.opt.cpoptions:append("$")
-- https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing

vim.opt.selection = "inclusive"

vim.opt.updatetime = 100
-- https://github.com/iamcco/markdown-preview.nvim/issues/4

vim.opt.backspace = {"indent", "eol", "start", "nostop"}

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.completeopt = {"menu", "preview"}

-- vim.opt.commentstring = "#%s"
