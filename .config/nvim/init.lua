vim.loader.enable()

--  debug
-- if true then return end



--  variable
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true



--  option
--  appearance
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = "yes"
-- vim.opt.signcolumn = "yes:2"
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

vim.opt.list = false
vim.opt.listchars = ""
-- vim.opt.listchars:append({eol            = "$"})
vim.opt.listchars:append({tab            = "▒▒"})
vim.opt.listchars:append({multispace     = "░"})
vim.opt.listchars:append({lead           = "░"})
vim.opt.listchars:append({trail          = "░"})

-- some unicode symbols (to keep these chars' original color, we wrap them in a variable):
local comment = [[·▫░▒▓█]]
-- use "ga" to get the code point

vim.opt.display = {"lastline"}

vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

vim.opt.fillchars = ""
vim.opt.fillchars:append({eob = " "})
vim.opt.fillchars:append({fold = " "})
vim.opt.fillchars:append({foldclose = "●"})
vim.opt.fillchars:append({foldopen = "○"})
vim.opt.fillchars:append({foldsep = "1"})

--  navigation
vim.opt.virtualedit = {"all"}
vim.opt.startofline = false
vim.opt.jumpoptions = {"stack"}
vim.opt.scrolloff = 0
vim.opt.whichwrap:append("[,]")
vim.opt.iskeyword:remove("_")
-- vim.opt.iskeyword:append("_")
-- vim.opt.iskeyword:append("-")
vim.opt.smoothscroll = true

--  keypress timeout
vim.opt.timeout = false
vim.opt.timeoutlen = 8
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0
-- in terminal, press <a-j> or <esc>j send the same keycode "^[j" to program
-- if you are vim, when you receive keycode "^[", you can choose wait or not
-- timeout	whether "^[j and zz" timeout
-- ttimeout	whether "^[j" timeout, t means terminal

--  search & substitute
vim.opt.hlsearch = false
vim.opt.incsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true

vim.opt.inccommand = ""

--  copy & paste
vim.opt.clipboard:prepend({"unnamed"})
vim.opt.clipboard:prepend({"unnamedplus"})

--  indent
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

--  match pair
vim.opt.matchpairs:append("<:>")
vim.opt.showmatch = true
vim.opt.matchtime = 1

--  auto linebreak
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

vim.opt.formatoptions = ""
-- https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

--  undo
vim.opt.undofile = true
vim.opt.undolevels = 1024

--  fold
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.foldtext = vim.fn.getline(vim.v.foldstart)
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0
vim.opt.foldmethod = "marker"

--  buffer window tab
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.splitkeep = "topline"
vim.opt.equalalways = true
vim.opt.winfixheight = false
vim.opt.cmdwinheight = 8
vim.opt.laststatus = 2
-- https://github.com/neovim/neovim/issues/18965

--  misc
vim.opt.cpoptions:remove("_")
-- vim.opt.cpoptions:append("v")
-- vim.opt.cpoptions:append("$")
-- https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing

vim.opt.updatetime = 100
-- https://github.com/iamcco/markdown-preview.nvim/issues/4

vim.opt.backspace = {"indent", "eol", "start", "nostop"}

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.completeopt = {"menu", "preview"}

vim.opt.commentstring = "#%s"



--  map
-- ":h map-table"
-- ":h key-notation"

vim.keymap.set("", "<space>", "<nop>")

vim.keymap.set("o", "{", function() return "V" .. vim.v.count1 .. "{" end, {silent = true, expr = true})
vim.keymap.set("o", "}", function() return "V" .. vim.v.count1 .. "}" end, {silent = true, expr = true})

-- vim.keymap.set("n", "<down>", ":put  _<cr>", {silent = true})
-- vim.keymap.set("n", "<up>",   ":put! _<cr>", {silent = true})
-- vim.keymap.set("n", "<left>",  [["=" "<cr>P]], {silent = true})
-- vim.keymap.set("n", "<right>", [["=" "<cr>p]], {silent = true})

-- vim.keymap.set("n", "<f3>", "gO", {remap = true})



vim.keymap.set("i", "<down>", "<c-n>")
vim.keymap.set("i", "<up>",   "<c-p>")



vim.keymap.set({"n", "x"}, "j", function()
	return vim.v.count == 0 and "gj" or "j"
	end, {expr = true})
vim.keymap.set({"n", "x"}, "k", function()
	return vim.v.count == 0 and "gk" or "k"
	end, {expr = true})

vim.keymap.set("", "<c-n>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-e>" end, {silent = true, expr = true})
vim.keymap.set("", "<c-p>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-y>" end, {silent = true, expr = true})
-- https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim

vim.keymap.set({"", "i"}, "<c-s>", "<cmd>normal zz<cr>")
vim.keymap.set({"", "i"}, "<c-j>", "<cmd>normal zt<cr>")
vim.keymap.set({"", "i"}, "<c-k>", "<cmd>normal zb<cr>")
vim.keymap.set({"", "i"}, "<c-h>", "<cmd>normal zz<c-n><cr>", {remap = true})
vim.keymap.set({"", "i"}, "<c-l>", "<cmd>normal zz<c-p><cr>", {remap = true})
vim.keymap.set("!", "<a-v>", "<c-k>")

vim.keymap.set({"", "i"}, "<f1>", "<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>")
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

vim.keymap.set({"", "i"}, "<f12>", "<cmd>q!<cr>")
vim.keymap.set({"", "i"}, "<f11>", "<cmd>set list!<cr>")



vim.api.nvim_create_user_command("RegisterUnnamedToSelection", [[let @+ = @" | let @* = @"]], {})
-- how shall we yank all lines except for the commented lines?
-- 	:v/--/y
-- failed, we just replace the content of the unnamed register over and over again...
-- we can't append to unnamed register...
-- we have to use the named register
-- 	qaq
-- 	:v/--/y A
-- we successfully yank the desired lines to the register a
-- we want to put the yanked text to another program, so we:
-- 	:let @+ = @a
-- this is okay, but since the unnamed register's content get updated together with the named register
-- we can simply:
-- 	:let @+ = @"

-- vim.api.nvim_create_user_command("Date", [[put =strftime("%F")]], {})
vim.api.nvim_create_user_command("Date",
	function()
		local text = os.date("%F")
		local lines = {text}
		vim.api.nvim_put(lines, "l", true, false)
	end,
	{})
-- https://cplusplus.com/reference/ctime/strftime/
-- https://www.runoob.com/cprogramming/c-function-strftime.html

vim.api.nvim_create_user_command("TrailRemove", [[%s/\s\+$//e]], {})
-- https://vim.fandom.com/wiki/Remove_unwanted_spaces

vim.api.nvim_create_user_command("SearchMiddleToggle",
	function()
		if vim.fn.mapcheck("n") == "" then
			vim.keymap.set("n", "n", "nzz")
			vim.keymap.set("n", "N", "Nzz")
		else
			vim.keymap.del("n", "n")
			vim.keymap.del("n", "N")
		end
	end,
	{})



--  function
--  compile
function compile()
	vim.cmd("w")

	local filetype = vim.bo.filetype
	if	filetype == "scheme" then
	elseif	filetype == "c" then
	elseif	filetype == "java" then
	elseif	filetype == "python" then
	elseif	filetype == "javascript" then
	else
		vim.cmd("MarkdownPreview")
	end
end
vim.keymap.set("n", "<f5>", compile)

--  paragraph_definition1 (para1)
local function para1_head_p(lnum)
	if lnum == 1 then
		return true
	end
	if vim.fn.getline(lnum) ~= "" and vim.fn.getline(lnum - 1) == "" then
		return true
	end
	return false
end

local function para1_tail_p(lnum)
	if lnum == vim.fn.line("$") then
		return true
	end
	if vim.fn.getline(lnum) ~= "" and vim.fn.getline(lnum + 1) == "" then
		return true
	end
	return false
end

local function para1_backward_lnum(lnum)
	if lnum == 1 then
		return lnum
	end
	if para1_head_p(lnum - 1) then
		return lnum - 1
	end
	return para1_backward_lnum(lnum - 1)
end

local function para1_forward_lnum(lnum)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if para1_tail_p(lnum + 1) then
		return lnum + 1
	end
	return para1_forward_lnum(lnum + 1)
end

para1_rep_call = function(func, arg, count)
	if count == 0 then
		return func(arg)
	else
		return para1_rep_call(func, func(arg), (count - 1))
	end
end

local function para1_backward()
	local lnum_current = vim.fn.line(".")
	local lnum_destination = para1_rep_call(para1_backward_lnum, lnum_current, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

local function para1_forward()
	local lnum_current = vim.fn.line(".")
	local lnum_destination = para1_rep_call(para1_forward_lnum, lnum_current, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

vim.keymap.set({"n", "v"}, "(", para1_backward)
vim.keymap.set({"n", "v"}, ")", para1_forward)
vim.keymap.set("o", "(", function() return ":normal V" .. vim.v.count1 .. "(<cr>" end, {silent = true, expr = true})
vim.keymap.set("o", ")", function() return ":normal V" .. vim.v.count1 .. ")<cr>" end, {silent = true, expr = true})
-- https://vi.stackexchange.com/questions/6101/is-there-a-text-object-for-current-line/6102#6102

--  paragraph_definition2 (para2)
local PARA2_TYPE1 = 1
local PARA2_TYPE2 = 2

local function para2_type(lnum, virtcol)
	local virtcol_max = vim.fn.virtcol({lnum, "$"})
	local a = virtcol >= virtcol_max
	if a then
		return PARA2_TYPE2
	else
		local col = vim.fn.virtcol2col(0, lnum, virtcol)
		local char = vim.api.nvim_buf_get_text(0, lnum-1, col-1, lnum-1, col-1+1, {})[1]
		local prestr = vim.api.nvim_buf_get_text(0, lnum-1, 0, lnum-1, col-1+1, {})[1]
		local b = (char == " " or char == "\t") and (prestr:match("^%s*$") ~= nil)
		if b then
			return PARA2_TYPE2
		else
			return PARA2_TYPE1
		end
	end
end

local function para2_type1_head_p(lnum, virtcol)
	local a = para2_type(lnum, virtcol) == PARA2_TYPE1
	local b = lnum == 1
	local c = para2_type(lnum-1, virtcol) == PARA2_TYPE2
	if a and (b or c) then
		return true
	else
		return false
	end
end

local function para2_type1_tail_p(lnum, virtcol)
	local a = para2_type(lnum, virtcol) == PARA2_TYPE1
	local b = lnum == vim.fn.line("$")
	local c = para2_type(lnum+1, virtcol) == PARA2_TYPE2
	if a and (b or c) then
		return true
	else
		return false
	end
end

local function para2_type2_head_p(lnum, virtcol)
	local a = para2_type(lnum, virtcol) == PARA2_TYPE2
	local b = lnum == 1
	local c = para2_type(lnum-1, virtcol) == PARA2_TYPE1
	if a and (b or c) then
		return true
	else
		return false
	end
end

local function para2_type2_tail_p(lnum, virtcol)
	local a = para2_type(lnum, virtcol) == PARA2_TYPE2
	local b = lnum == vim.fn.line("$")
	local c = para2_type(lnum+1, virtcol) == PARA2_TYPE1
	if a and (b or c) then
		return true
	else
		return false
	end
end

local function para2_backward_lnum(lnum, virtcol)
	if lnum == 1 then
		return lnum
	end
	if para2_type1_head_p(lnum-1, virtcol) or para2_type2_head_p(lnum-1, virtcol) then
		return lnum - 1
	end
	return para2_backward_lnum(lnum - 1, virtcol)
end

local function para2_forward_lnum(lnum, virtcol)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if para2_type1_tail_p(lnum+1, virtcol) or para2_type2_tail_p(lnum+1, virtcol) then
		return lnum + 1
	end
	return para2_forward_lnum(lnum + 1, virtcol)
end

para2_rep_call = function(func, arg1, arg2, count)
	if count == 0 then
		return func(arg1, arg2)
	else
		return para2_rep_call(func, func(arg1, arg2), arg2, (count - 1))
	end
end

local function para2_backward()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2_rep_call(para2_backward_lnum, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

local function para2_forward()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2_rep_call(para2_forward_lnum, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

vim.keymap.set({"n", "v"}, "<home>",   para2_backward)
vim.keymap.set({"n", "v"}, "<end>", para2_forward)

vim.keymap.set("o", "<home>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<home>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})

vim.keymap.set("o", "<end>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<end>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})



local function para2_backward_lnum_special(lnum, virtcol)
	if lnum == 1 then
		return lnum
	end
	if para2_type1_head_p(lnum-1, virtcol) then
		return lnum - 1
	end
	return para2_backward_lnum_special(lnum - 1, virtcol)
end

local function para2_forward_lnum_special(lnum, virtcol)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if para2_type1_head_p(lnum+1, virtcol) then
		return lnum + 1
	end
	return para2_forward_lnum_special(lnum + 1, virtcol)
end

local function para2_backward_special()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2_rep_call(para2_backward_lnum_special, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

local function para2_forward_special()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2_rep_call(para2_forward_lnum_special, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

vim.keymap.set({"n", "v"}, "<pageup>",   para2_backward_special)
vim.keymap.set({"n", "v"}, "<pagedown>", para2_forward_special)

vim.keymap.set("o", "<pageup>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<pageup>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})

vim.keymap.set("o", "<pagedown>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<pagedown>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})



--  empty_line (eml)
eml = {}
eml.fun = function(direction)
	eml.direction = direction
	vim.go.operatorfunc = "v:lua.eml.fun_callback"
	return "g@l"
end
eml.fun_callback = function()
	local lnum_current = vim.fn.line(".")
	vim.fn.append((eml.direction and lnum_current or lnum_current - 1), vim.fn["repeat"]({""}, vim.v.count1))
	if eml.direction then
		vim.api.nvim_feedkeys(vim.v.count1 .. "j", "n", false)
	else
		vim.api.nvim_feedkeys(vim.v.count1 .. "k", "n", false)
	end
end
vim.keymap.set("n", "<down>", function() return eml.fun(true)  end, {expr = true})
vim.keymap.set("n", "<up>",   function() return eml.fun(false) end, {expr = true})

--  empty_char (emc)
emc = {}
emc.fun = function(direction)
	emc.direction = direction
	vim.go.operatorfunc = "v:lua.emc.fun_callback"
	return "g@l"
end
emc.fun_callback = function()
	vim.api.nvim_put({string.rep(" ", vim.v.count1)}, "c", emc.direction, true)
	if emc.direction then
		vim.api.nvim_feedkeys("h", "n", false)
	else
		vim.api.nvim_feedkeys(vim.v.count1 .. "h", "n", false)
	end
end
vim.keymap.set("n", "<right>", function() return emc.fun(true)  end, {expr = true})
vim.keymap.set("n", "<left>",  function() return emc.fun(false) end, {expr = true})

--  xX
-- fix x and X key when "virtualedit=all"
-- fuck the fucking chaos index of row and col
-- fuck lua for 1-based index
xX = {}
xX.fun = function(direction)
	xX.direction = direction
	vim.go.operatorfunc = "v:lua.xX.fun_callback"
	return "g@l"
end
xX.fun_callback = function()
	-- local pos1 = vim.api.nvim_win_get_cursor(0)
	-- local row1 = pos1[1]
	-- local col1 = pos1[2]

	local pos1 = vim.fn.getcharpos(".")
	local row1 = pos1[2]
	local col1 = pos1[3]
	local col1_byte = vim.fn.col(".")

	if xX.direction then
		vim.fn.setcursorcharpos(row1, col1 + vim.v.count1)
	else
		vim.fn.setcursorcharpos(row1, col1 - vim.v.count1)
	end

	local pos2 = vim.fn.getcharpos(".")
	local row2 = pos2[2]
	local col2 = pos2[3]
	local col2_byte = vim.fn.col(".")

	local row_beg
	local row_end
	if row1 <= row2 then
		row_beg = row1
		row_end = row2
	else
		row_beg = row2
		row_end = row1
	end

	local col_byte_beg
	local col_byte_end
	if col1_byte <= col2_byte then
		col_byte_beg = col1_byte
		col_byte_end = col2_byte
	else
		col_byte_beg = col2_byte
		col_byte_end = col1_byte
	end

	local text = vim.api.nvim_buf_get_text(0, row_beg - 1, col_byte_beg - 1, row_end - 1, col_byte_end - 1, {})
	-- print(vim.inspect(text))
	vim.fn.setreg("",  text, "c")
	vim.fn.setreg("-", text, "c")
	vim.fn.setreg("*", text, "c")
	vim.fn.setreg("+", text, "c")

	vim.api.nvim_buf_set_text(0, row_beg - 1, col_byte_beg - 1, row_end - 1, col_byte_end - 1, {})
end
vim.keymap.set("n", "x", function() return xX.fun(true)  end, {expr = true})
vim.keymap.set("n", "X", function() return xX.fun(false) end, {expr = true})

--  misc
function time()
	vim.api.nvim_out_write(vim.fn.system({"date", "--iso-8601=ns"}))
end



--  autocmd
-- https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup

--  change option
local change_option_augroup = vim.api.nvim_create_augroup("change_option", {clear = true})

-- vim.api.nvim_create_autocmd(
-- 	{},
-- 	{
-- 		group = change_option_augroup,
-- 		pattern = {"*"},
-- 		callback = function()
-- 			time()
-- 			print(vim.opt.modifiable:get())
-- 			if vim.opt.modifiable:get() then
-- 				return
-- 			end
-- 			vim.opt_local.number = false
-- 			vim.opt_local.relativenumber = false
-- 		end,
-- 	})

--  fix cursor position when changing mode
local cursor_position_augroup = vim.api.nvim_create_augroup("cursor_position", {clear = true})

vim.api.nvim_create_autocmd(
	"InsertLeave",
	{
		group = cursor_position_augroup,
		pattern = {"*"},
		command = "normal `^",
	})

-- vim.api.nvim_create_autocmd(
-- 	"ModeChanged",
-- 	{
-- 		group = cursor_position_augroup,
-- 		pattern = {"n:*"},
-- 		command = "normal mn",
-- 	})
-- -- may conflict with plugin! (vim-mark)

-- vim.api.nvim_create_autocmd(
-- 	"ModeChanged",
-- 	{
-- 		group = cursor_position_augroup,
-- 		pattern = {"[vV\x16]*:n"},
-- 		command = "silent! normal `n",
-- 	})
-- -- use "silent!" to ignore the error message when press "Vd"
-- -- may conflict with plugin! (mini.ai)

--  eol extmark at cursor line
-- https://github.com/echasnovski/mini.nvim/issues/990

local eol_extmark_ns_id = vim.api.nvim_create_namespace("eol_extmark")
local eol_extmark_opts = {
	virt_text = {{"○", "EolExtmark"}},
	virt_text_pos = "overlay",
}
local eol_extmark_id
local show_eol_at_cursor_line = function(args)
	if vim.api.nvim_get_current_buf() ~= args.buf then return end
	eol_extmark_opts.id = eol_extmark_id
	local line = vim.fn.line(".") - 1
	eol_extmark_id = vim.api.nvim_buf_set_extmark(args.buf, eol_extmark_ns_id, line, -1, eol_extmark_opts)
end

local eol_extmark_augroup = vim.api.nvim_create_augroup("eol_extmark", {clear = true})
vim.api.nvim_create_autocmd(
	{"BufEnter", "CursorMoved", "CursorMovedI"},
	{
		group = eol_extmark_augroup,
		callback = show_eol_at_cursor_line,
	})

vim.api.nvim_set_hl(0, "EolExtmark", {link = "Comment"})

--  auto save
-- local timer = vim.uv.new_timer()
-- timer:start(0, 100, vim.schedule_wrap(function()
-- 	vim.cmd("echo mode(1)")
-- 	end))

local auto_save_augroup = vim.api.nvim_create_augroup("auto_save", {clear = true})

vim.api.nvim_create_autocmd(
	{"TextChanged", "InsertLeave"},
	{
		group = auto_save_augroup,
		pattern = {"*"},
		command = "silent! wa",
	})

vim.api.nvim_create_autocmd(
	{"FocusLost", "QuitPre"},
	{
		group = auto_save_augroup,
		pattern = {"*"},
		nested = true,
		command = "silent! wa",
	})
-- https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost

--  filetype
local filetype_augroup = vim.api.nvim_create_augroup("filetype", {clear = true})

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = filetype_augroup,
		pattern = {"man"},
		callback = function()
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.signcolumn = "no"
		end,
	})

--  filename
local filename_augroup = vim.api.nvim_create_augroup("filename", {clear = true})

vim.api.nvim_create_autocmd(
	"BufRead",
	{
		group = filename_augroup,
		pattern = {"log.txt"},
		command = "silent $",
	})

vim.api.nvim_create_autocmd(
	"BufRead",
	{
		group = filename_augroup,
		pattern = {"*.txt"},
		command = "set filetype=markdown",
	})



--  builtin plugin
vim.cmd([[
filetype on
filetype plugin off
filetype indent off
syntax off
]])

--[[
it's possible to turn off specific filetype plugin

e.g. turn off markdown filetype plugin:

```
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1
```

save the file above as ~/.config/nvim/ftplugin/markdown.vim
this will turn off markdown filetype plugin,
which located at $VIMRUNTIME/ftplugin/markdown.vim
--]]

vim.fn.digraph_set("oo", "●")
vim.fn.digraph_set("xx", "×")
vim.fn.digraph_set("-<", "←")
vim.fn.digraph_set("-^", "↑")
vim.fn.digraph_set("^v", "↕")



--  plugin
-- https://lazy.folke.io/installation
-- https://lazy.folke.io/configuration
-- https://github.com/LazyVim/LazyVim/discussions/1483

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazyplugins =
{
----------------------------------------------------------------
{
	"aidancz/nofrils",
	dev = true,
	lazy = false,
	priority = 1000,
	-- https://lazy.folke.io/spec/lazy_loading#-colorschemes
	config = function()
		vim.cmd("colorscheme nofrils")
	end,
},

--[[
{
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {char = "┃"},
		})
	end,
},
--]]

--[[
{
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({})
	end,
},
--]]

{
	"utilyre/sentiment.nvim",
	init = function()
		vim.g.loaded_matchparen = 1
		vim.opt.showmatch = false
	end,
	config = function()
		require("sentiment").setup({
			included_modes = {
				n = true,
				i = true,
			},
			delay = 0,
		})
	end,
},

--[[
{
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return ""
			end,
			fold_virt_text_handler = function() return vim.fn.getline(vim.v.foldstart) end,
		})
	end,
},
--]]

{
	"inkarkat/vim-mark",
	dependencies = {
		"inkarkat/vim-ingo-library",
	},
	config = function()
		-- vim.api.nvim_set_hl(0, "MarkWord1", {link = "nofrils-red-bg"})
		vim.api.nvim_set_hl(0, "MarkWord1", {link = "nofrils-shadow-bg"})
		vim.api.nvim_set_hl(0, "MarkWord2", {link = "nofrils-green-bg"})
		vim.api.nvim_set_hl(0, "MarkWord3", {link = "nofrils-yellow-bg"})
		vim.api.nvim_set_hl(0, "MarkWord4", {link = "nofrils-blue-bg"})
		vim.api.nvim_set_hl(0, "MarkWord5", {link = "nofrils-magenta-bg"})
		vim.api.nvim_set_hl(0, "MarkWord6", {link = "nofrils-cyan-bg"})
	end,
},

{
	"chentoast/marks.nvim",
	config = function()
		require("marks").setup({
			default_mappings = true,
			builtin_marks = {".", "<", ">", "^"},
			cyclic = true,
			force_write_shada = false,
			refresh_interval = 150,
			sign_priority = {lower=10, upper=15, builtin=8, bookmark=20},
			excluded_filetypes = {},
			excluded_buftypes = {},
			bookmark_0 = {
				sign = "⚑",
				virt_text = "",
				annotate = false,
			},
			mappings = {}
		})
	end,
},

--[[
{
	"kylechui/nvim-surround",
	config = function()
		require("nvim-surround").setup({})
	end,
},
--]]

{
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = {
				block = "gbb",
			},
		})
	end,
},

--[[
{
	"inkarkat/vim-ReplaceWithRegister",
},
--]]

{
	"echasnovski/mini.nvim",
	version = false,
	config = function()

		require("mini.ai").setup({
			custom_textobjects = {
				['('] = { '%b()', '^.().*().$' },
				[')'] = { '%b()', '^.%s*().-()%s*.$' },
				['['] = { '%b[]', '^.().*().$' },
				[']'] = { '%b[]', '^.%s*().-()%s*.$' },
				['{'] = { '%b{}', '^.().*().$' },
				['}'] = { '%b{}', '^.%s*().-()%s*.$' },
				['<'] = { '%b<>', '^.().*().$' },
				['>'] = { '%b<>', '^.%s*().-()%s*.$' },
				b = {{'%b()', '%b[]', '%b{}', '%b<>'}, '^.().*().$'},

				-- -- ['"'] = { '"().-()"' },
				-- -- https://github.com/echasnovski/mini.nvim/issues/1281
				-- ["'"] = { "'.-'", '^.().*().$' },
				-- ['"'] = { '".-"', '^.().*().$' },
				-- ['`'] = { '`.-`', '^.().*().$' },
				-- q = { { "'.-'", '".-"', '`.-`' }, '^.().*().$' },
				-- -- 金铁击石全无力 大圣天蓬遭虎欺 枪刀戟剑浑不避 石猴似你不似你

				n = require("mini.extra").gen_ai_spec.number(),
				c = function(ai_type)
				-- current line
					local line_num = vim.fn.line(".")
					local col_max = math.max(1, #vim.api.nvim_get_current_line())
					local region = {from = {line = line_num, col = 1}, to = {line = line_num, col = col_max}}
					if ai_type == "i" then
						region.vis_mode = "v"
					elseif ai_type == "a" then
						region.vis_mode = "V"
					end
					return region
				end,
				i = function(ai_type)
					local region = (require("mini.extra").gen_ai_spec.indent())(ai_type)
					for _, i in ipairs(region) do
						i.vis_mode = "V"
					end
					return region
				end,
				e = function(ai_type)
				-- entire buffer
					local region = (require("mini.extra").gen_ai_spec.buffer())("a")
					region.vis_mode = "V"
					return region
				end,
			},
			mappings = {
				around_next = "al",
				inside_next = "il",
				around_last = "ah",
				inside_last = "ih",

				goto_left  = "gh",
				goto_right = "gl",
			},
			search_method = "cover_or_next",
		})

		require("mini.align").setup({
			mappings = {
				start = "gn",
				start_with_preview = "gN",
			},
		})
		vim.keymap.set("n", "gnn", "gn_", {remap = true})

		require("mini.bracketed").setup({})

		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {add = "■", change = "■", delete = "■"},
			},
			delay = {
				text_change = 100,
			},
			mappings = {
				apply = "ga",
				reset = "gr",
				textobject = "gh",
			},
		})
		vim.api.nvim_set_hl(0, "MiniDiffOverChange", {link = "nofrils-yellow"})
		vim.api.nvim_set_hl(0, "MiniDiffOverContext", {link = "nofrils-default"})

		require("mini.extra").setup({})

		require("mini.icons").setup({
			style = "ascii",
		})

		require("mini.move").setup({
			options = {
				reindent_linewise = false,
			},
		})

		require("mini.operators").setup({
			replace = {
				prefix = "s",
				reindent_linewise = false,
			},
		})
		vim.keymap.set("n", "S", "s$", {remap = true})

		require("mini.surround").setup({
			custom_surroundings = {
				['('] = { input = { '%b()', '^.().*().$'       }, output = { left = '(',  right = ')'  } },
				[')'] = { input = { '%b()', '^.%s*().-()%s*.$' }, output = { left = '( ', right = ' )' } },
				['['] = { input = { '%b[]', '^.().*().$'       }, output = { left = '[',  right = ']'  } },
				[']'] = { input = { '%b[]', '^.%s*().-()%s*.$' }, output = { left = '[ ', right = ' ]' } },
				['{'] = { input = { '%b{}', '^.().*().$'       }, output = { left = '{',  right = '}'  } },
				['}'] = { input = { '%b{}', '^.%s*().-()%s*.$' }, output = { left = '{ ', right = ' }' } },
				['<'] = { input = { '%b<>', '^.().*().$'       }, output = { left = '<',  right = '>'  } },
				['>'] = { input = { '%b<>', '^.%s*().-()%s*.$' }, output = { left = '< ', right = ' >' } },
			},
			mappings = {
				add     = "ys",
				delete  = "ds",
				replace = "cs",

				suffix_last = "h",
				suffix_next = "l",
			},
			respect_selection_type = true,
			search_method = "cover_or_next",
		})
		vim.keymap.del("x", "ys")
		vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], {silent = true})
		vim.keymap.set("n", "yss", "ys_", {remap = true})
		-- vim.keymap.set("", "s", "<nop>") -- if using `s` for prefix

		-- require("mini.trailspace").setup({})
		-- vim.api.nvim_set_hl(0, "MiniTrailspace", {link = "nofrils-yellow-bg"})

	end,
},

{
	"mbbill/undotree",
},

{
	"h-hg/fcitx.nvim",
},

{
	"dhruvasagar/vim-table-mode",
	config = function()
		vim.g.table_mode_corner = "|"
	end,
},

{
	"iamcco/markdown-preview.nvim",
	build = function() vim.fn["mkdp#util#install"]() end,
	config = function()
		vim.g.mkdp_auto_start = false
		vim.g.mkdp_auto_close = true
		vim.g.mkdp_refresh_slow = false
		vim.g.mkdp_command_for_global = false
		vim.g.mkdp_open_to_the_world = false
		vim.g.mkdp_open_ip = ""
		vim.g.mkdp_browser = ""
		vim.g.mkdp_echo_preview_url = false
		-- function open_browser(url)
		-- 	vim.cmd("silent !firefox --new-window" .. " " .. url)
		-- end
		vim.cmd([[
		function OpenBrowser(url)
			silent execute "!firefox --new-window" . " " . a:url
		endfunction
		]])
		vim.g.mkdp_browserfunc = "OpenBrowser"
		vim.g.mkdp_preview_options = {
			mkit = {breaks = true},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = false,
			sync_scroll_type = "middle",
			hide_yaml_meta = true,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = true,
		}
		vim.g.mkdp_markdown_css = ""
		vim.g.mkdp_highlight_css = ""
		vim.g.mkdp_port = ""
		vim.g.mkdp_page_title = "${name}"
		vim.g.mkdp_filetypes = {"markdown", "text"}
	end,
},

{
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		-- "nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			keymaps = {
				["?"]      = false,
				["<C-j>"]  = false,
				["<C-k>"]  = false,
				["<C-s>"]  = false,
				["<C-v>"]  = false,
				["<a-j>"]  = "actions.down_and_scroll",
				["<a-k>"]  = "actions.up_and_scroll",
				["<a-s>"]  = "actions.jump_split",
				["<a-v>"]  = "actions.jump_vsplit",
			},
			layout = {
				width = 0.5,
				max_width = 0.5,
				min_width = 0.5,
				default_direction = "float",
				resize_to_content = false,
			},
			float = {
				height = 0.8,
				max_height = 0.8,
				min_height = 0.8,
				border = "single",
				relative = "editor",
			},
		})
		vim.keymap.set("n", "<f3>", "<cmd>AerialToggle<cr>")
	end,
},

--[[
{
	"hedyhli/outline.nvim",
	config = function()
		require("outline").setup({})
	end,
},
--]]

{
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable "make" == 1
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim"
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					horizontal = {
						preview_cutoff = 0,
						preview_width = 0.5
					},
				},
				mappings = {
					i = {
						["<esc>"] = "close",
						["<c-u>"] = false,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
	end,
},

{
	"ibhagwan/fzf-lua",
	config = function()
		require("fzf-lua").setup({
			keymap = {
				builtin = {
				},
				fzf = {
					["f12"] = "abort",
				},
			},
		})
	end,
},

{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = {},
			auto_install = true,
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false,
			},
			-- indent = {
			-- 	enable = true,
			-- },
		})

		vim.treesitter.query.set("scheme",          "highlights", "(comment) @comment")
		vim.treesitter.query.set("c",               "highlights", "(comment) @comment")
		-- vim.treesitter.query.set("java",            "highlights", "")
		vim.treesitter.query.set("python",          "highlights", "(comment) @comment")
		vim.treesitter.query.set("javascript",      "highlights", "(comment) @comment")
		vim.treesitter.query.set("markdown",        "highlights", "")
		vim.treesitter.query.set("markdown_inline", "highlights", "")
		vim.treesitter.query.set("lua",             "highlights", "(comment) @comment")
		vim.treesitter.query.set("css",             "highlights", "(comment) @comment")

		vim.treesitter.language.register("bash", "zsh")
		-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#using-an-existing-parser-for-another-filetype
	end,
},

--[[
{
	"neovim/nvim-lspconfig",
	dependencies = {
		-- {"williamboman/mason.nvim"},
		-- {"williamboman/mason-lspconfig.nvim"},
		{"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
	},
	config = function()
		local lsp_zero = require("lsp-zero")
		lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({buffer = bufnr})
				end)
		require("lspconfig").lua_ls.setup({})
	end,
},
--]]

{
	"hrsh7th/nvim-cmp",
	dependencies = {
		{"hrsh7th/cmp-path"},
		{"hrsh7th/cmp-buffer"},
		{"hrsh7th/cmp-cmdline"},
		{"hrsh7th/cmp-nvim-lsp"},
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			window = {
				completion    = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{
					{name = "path"},
				},
				{
					{name = "cmdline"},
				}),
		})
		-- cmp.setup.cmdline({"/", "?"}, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = {
		-- 		{name = "buffer"},
		-- 	}
		-- })
	end,
},

--[[
{
	"L3MON4D3/LuaSnip",
},
--]]

{
	"mikavilpas/yazi.nvim",
	config = function()
		require("yazi").setup({})
		vim.api.nvim_create_user_command("Yazi", function() require("yazi").yazi() end, {})
	end,
},

{
	-- "bfredl/nvim-luadev",
	"ii14/neorepl.nvim",
	-- https://www.reddit.com/r/neovim/comments/11lep0t/ineditor_lua_repl_nvimluadev_vs_neoreplnvim/
},

{
	"michaelb/sniprun",
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			selected_interpreters = {
				"Lua_nvim",
			},
			repl_enable = {
			},
			interpreter_options = {
			},
			display = {
				"Classic",
			},
		})
	end,
},

--[[
{
	"lambdalisue/vim-suda",
},
--]]

{
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup()
	end,
},
----------------------------------------------------------------
}

require("lazy").setup({
	spec = lazyplugins,
	dev = {
		path = "~/sync_git",
	},
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})

vim.cmd([[
]])
