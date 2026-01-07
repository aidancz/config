--[[

:h map-table

:h vim-modes
- normal:           n
- visual:           x
- select:           s
- insert:           i
- cmdline:          c
- terminal:         t
- operator-pending: o

:h key-notation

--]]

-- # {"n", "x", "s", "i", "c", "t", "o"}

-- ## leader keys themself should do nothing

vim.keymap.set({"n", "x", "s", "i", "c", "t", "o"}, "<f2>", "<nop>")

vim.keymap.set({"n", "x", "o"}, "<space>", "<nop>")
vim.keymap.set({"n", "x", "o"}, "<cr>",    "<nop>")
-- vim.keymap.set({"n", "x", "o"}, "g",       "<nop>") -- breaks g@ in poorly written plugins
vim.keymap.set({"n", "x", "o"}, "s",       "<nop>")

-- ## bypass the <c-i> and <tab> conflict, etc

vim.keymap.set({"n", "x", "s", "i", "c", "t", "o"}, "<c-i>", "<c-i>")
vim.keymap.set({"n", "x", "s", "i", "c", "t", "o"}, "<c-m>", "<c-m>")

-- ## quit

vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<f1>",
	function()
		local is_not_floating_window = function(win)
			return
			vim.api.nvim_win_get_config(win).relative == ""
		end
		local win_current = vim.api.nvim_get_current_win()
		local wins = vim.api.nvim_list_wins()
		local wins_without_floating = vim.tbl_filter(is_not_floating_window, wins)
		if
			is_not_floating_window(win_current)
			and
			#wins_without_floating == 1
		then
			vim.cmd("q!")
		else
			vim.cmd("close")
		end
	end
)
-- `:q` ignore help window, so create this mapping, see `:h edit-window`
-- https://vi.stackexchange.com/questions/9479/what-is-the-difference-between-quit-and-close-commands

vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<f2><f1>",
	function()
		vim.cmd("qa!")
	end
)

vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<f25>", -- <c-f1>
	function() vim.cmd("restart") end
)
-- https://github.com/neovim/neovim/issues/35166

-- ## repeat last command

-- vim.keymap.set({"n", "x"}, "<tab>", ":<up><cr>")
-- vim.keymap.set({"n", "x"}, "<tab>", "@:")
vim.keymap.set(
	{"n", "x"},
	"<tab>",
	function() vim.cmd(vim.fn.histget("cmd", -1)) end
)

-- ## open terminal

vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<f2><cr>",
	"<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>"
)
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

-- # {"n", "x", "o"}

-- ## (vert (next prev)) the behavior is based on vim.v.count

vim.keymap.set(
	{"n", "x"},
	"j",
	function()
		return vim.v.count == 0 and "gj" or "j"
	end,
	{
		expr = true,
	}
)
vim.keymap.set(
	{"n", "x"},
	"k",
	function()
		return vim.v.count == 0 and "gk" or "k"
	end,
	{
		expr = true,
	}
)

-- ## (vert (next-final prev-final))

vim.keymap.set({"n", "x", "o"}, "gg", "G")
vim.keymap.set({"n", "x", "o"}, "ss", "gg")
vim.keymap.set({"n", "x", "o"}, "G",  "G")
vim.keymap.set({"n", "x", "o"}, "S",  "gg")

-- ## (hori (next-word^ prev-word^ next-word$ prev-word$)) (hori (next-WORD^ prev-WORD^ next-WORD$ prev-WORD$))

vim.keymap.set({"n", "x", "o"}, "o", "w")
vim.keymap.set({"n", "x", "o"}, "w", "b")
-- vim.keymap.set({"n", "x", "o"}, "eo", "e")
-- vim.keymap.set({"n", "x", "o"}, "ew", "ge")

-- vim.keymap.set({"n", "x", "o"}, "vo", "W")
-- vim.keymap.set({"n", "x", "o"}, "mw", "B")
-- vim.keymap.set({"n", "x", "o"}, "veo", "E")
-- vim.keymap.set({"n", "x", "o"}, "mew", "gE")

-- ## (hori (next-final prev-final))

vim.keymap.set({"n", "x", "o"}, "]", "$")
vim.keymap.set({"n", "x", "o"}, "[", "0")

-- ## (search (next prev)) the search direction does not depend on the previous search command

-- vim.keymap.set({"n", "x", "o"}, "n", function() return vim.v.searchforward == 1 and "n" or "N" end, {expr = true})
-- vim.keymap.set({"n", "x", "o"}, "b", function() return vim.v.searchforward == 1 and "N" or "n" end, {expr = true})
-- -- https://vi.stackexchange.com/questions/2365/how-can-i-get-n-to-go-forward-even-if-i-started-searching-with-or

vim.keymap.set({"n", "x", "o"}, "gn", "gn")
vim.keymap.set({"n", "x", "o"}, "gb", "gN")

-- ## (visual other-end)

vim.keymap.set("x", "r", "o")
vim.keymap.set("x", "R", "O")

-- ## (jumplist (next prev))

vim.keymap.set({"n", "x"}, "<c-w>", "<c-o>")
vim.keymap.set({"n", "x"}, "<c-o>", "<c-i>")

-- ## (quickfix (next prev))

require("luaexec").add({
	code = [[return "<cmd>cnext<cr>"]],
	from = "quickfix",
	name = "next",
	keys = {{"n", "x"}, "gc"},
})

require("luaexec").add({
	code = [[return "<cmd>cprevious<cr>"]],
	from = "quickfix",
	name = "prev",
	keys = {{"n", "x"}, "gC"},
})

-- ## (buffer (next prev))

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = 1 end

local buf = vim.api.nvim_get_current_buf()
local buf_list = vim.api.nvim_list_bufs()
local buf_is_listed = function(buf)
	if buf == 0 then return false end
	-- https://github.com/neovim/neovim/issues/33270
	return vim.fn.buflisted(buf) ~= 0
end

local next
next = function(buf)
	if buf_is_listed(buf + 1) then
		return (buf + 1)
	end
	if (buf + 1) > buf_list[#buf_list] then
		return next(buf_list[1] - 1)
	end
	return next(buf + 1)
end
for i = 1, count do
	buf = next(buf)
end
vim.api.nvim_set_current_buf(buf)
]],
	from = "buffer",
	name = "next",
	keys = {{"n", "x"}, "<down>"},
})

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = 1 end

local buf = vim.api.nvim_get_current_buf()
local buf_list = vim.api.nvim_list_bufs()
local buf_is_listed = function(buf)
	if buf == 0 then return false end
	-- https://github.com/neovim/neovim/issues/33270
	return vim.fn.buflisted(buf) ~= 0
end

local prev
prev = function(buf)
	if buf_is_listed(buf - 1) then
		return (buf - 1)
	end
	if (buf - 1) < buf_list[1] then
		return prev(buf_list[#buf_list] + 1)
	end
	return prev(buf - 1)
end
for i = 1, count do
	buf = prev(buf)
end
vim.api.nvim_set_current_buf(buf)
]],
	from = "buffer",
	name = "prev",
	keys = {{"n", "x"}, "<up>"},
})

-- ## (window leader)

vim.keymap.set({"n", "x"}, "<space>w", "<c-w>")

-- ## (window (next prev))

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd w")
]],
	from = "window",
	name = "next",
	keys = {{"n", "x"}, "<right>"},
})

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd W")
]],
	from = "window",
	name = "prev",
	keys = {{"n", "x"}, "<left>"},
})

-- ## (window_hori (next prev))

require("luaexec").add({
	code = [[return "zl"]],
	from = "window_hori",
	name = "next",
	keys = {{"n", "x"}, "zl"},
})

require("luaexec").add({
	code = [[return "zh"]],
	from = "window_hori",
	name = "prev",
	keys = {{"n", "x"}, "zh"},
})

-- ## (window_height (next prev))

require("luaexec").add({
	code = [[return "<c-w>+"]],
	from = "window_height",
	name = "next",
	keys = {{"n", "x"}, "<space>w+"},
})

require("luaexec").add({
	code = [[return "<c-w>-"]],
	from = "window_height",
	name = "prev",
	keys = {{"n", "x"}, "<space>w-"},
})

-- ## (window_width (next prev))

require("luaexec").add({
	code = [[return "<c-w>>"]],
	from = "window_width",
	name = "next",
	keys = {{"n", "x"}, "<space>w>"},
})

require("luaexec").add({
	code = [[return "<c-w><"]],
	from = "window_width",
	name = "prev",
	keys = {{"n", "x"}, "<space>w<"},
})

-- ## (window (/ : ?))

vim.keymap.set({"n", "x"}, "g/", "q/")
vim.keymap.set({"n", "x"}, "g:", "q:")
vim.keymap.set({"n", "x"}, "g?", "q?")

-- ## (tab (next prev))

require("luaexec").add({
	code = [[return "gt"]],
	from = "tab",
	name = "next",
	keys = {{"n", "x"}, "gt"},
})

require("luaexec").add({
	code = [[return "gT"]],
	from = "tab",
	name = "prev",
	keys = {{"n", "x"}, "gT"},
})

-- ## ban cc dd yy C D Y

-- vim.keymap.set("n", "cc", "<nop>")
-- vim.keymap.set("n", "dd", "<nop>")
-- vim.keymap.set("n", "yy", "<nop>")

vim.keymap.set("n", "C",  "<nop>")
vim.keymap.set("n", "D",  "<nop>")
vim.keymap.set("n", "Y",  "<nop>")

-- ## delete

vim.keymap.set({"n", "x"}, "e", "d")

-- ## (undotree (next prev)) undo and redo

vim.keymap.set({"n", "x"}, "<plug>(redrawstatus)", function() vim.cmd("redrawstatus") end)

vim.keymap.set({"n", "x"}, "<bs>",  "<cmd>undo<cr><plug>(redrawstatus)")
vim.keymap.set({"n", "x"}, "<del>", "<cmd>redo<cr><plug>(redrawstatus)")

-- # {"i", "c"}

-- ## digraph

vim.keymap.set({"i", "c"}, "<f2>v", "<c-k>")

vim.fn.digraph_set("oo", "●")
vim.fn.digraph_set("xx", "×")
vim.fn.digraph_set("-<", "←")
vim.fn.digraph_set("-^", "↑")
vim.fn.digraph_set("^v", "↕")

-- ## insert mode <right> and <left> should not break dot-repeat

vim.keymap.set("i", "<right>", "<c-g>U<right>")
vim.keymap.set("i", "<left>",  "<c-g>U<left>")
-- insert mode press print()<left>abc and try to use dot-repeat
-- default: abc
-- now: print(abc)

-- ## insert mode <s-cr> should do the opposite of <cr>

vim.keymap.set(
	"i",
	"<s-cr>",
	function()
		feedkeys("<cr><cmd>.m.-2<cr>", "n")
	end
)

-- ## cmdline mode <c-w> should ignore iskeyword

vim.keymap.set(
	"c",
	"<c-w>",
	function()
		local cache_iskeyword = vim.bo.iskeyword
		vim.bo.iskeyword = vim.go.iskeyword
		feedkeys("<c-w>", "n")
		vim.schedule(function()
			vim.bo.iskeyword = cache_iskeyword
		end)
	end
)

-- # ex mode (bind to command)

-- ## compile

require("luaexec").add({
	code =
[[
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
]],
	name = "compile",
})

-- ## transfer_register

require("luaexec").add({
	code =
[=[
vim.cmd([[
let @+ = @"
let @* = @"
]])
]=],
	name = "transfer_register",
	desc =
[[
how shall we yank all lines except for the commented lines?
	:v/--/y
failed, we just replace the content of the unnamed register over and over again...
we can't append to unnamed register...
we have to use the named register
	qaq
	:v/--/y A
we successfully yank the desired lines to the register a
we want to put the yanked text to another program, so we:
	:let @+ = @a
this is okay, but since the unnamed register's content get updated together with the named register
we can simply:
	:let @+ = @"
]],
})

-- ## remove_trail

require("luaexec").add({
	code =
[=[
vim.cmd([[%s/\s\+$//e]])
]=],
	name = "remove_trail",
	desc =
[[
https://vim.fandom.com/wiki/Remove_unwanted_spaces
]],
})

-- ## remove_last_eol

require("luaexec").add({
	code =
[[
vim.o.binary = true
vim.o.fixendofline = false
vim.o.endofline = false
]],
	name = "remove_last_eol",
	desc =
[[
https://stackoverflow.com/questions/1050640/how-to-stop-vim-from-adding-a-newline-at-end-of-file
]],
})

-- ## deduplicate_multiple_blank_lines

require("luaexec").add({
	code = [[vim.cmd("%!cat -s")]],
	name = "deduplicate_multiple_blank_lines",
	desc =
[[
https://unix.stackexchange.com/questions/12812/replacing-multiple-blank-lines-with-a-single-blank-line-in-vim-sed
]],
})

-- ## zen

require("luaexec").add({
	code =
[[
vim.wo.foldcolumn = "0"
vim.wo.signcolumn = "no"
-- vim.wo.numberwidth = 1
vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.statuscolumn = ""
]],
	name = "zen",
})

-- # used before

--[=[

-- ## consistent scrolling

vim.keymap.set({"n", "x"}, "<c-e>", function() return 1                                           .. "<c-d>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-y>", function() return 1                                           .. "<c-u>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-n>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-d>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-p>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-u>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-d>", function() return math.ceil(vim.api.nvim_win_get_height(0)/2) .. "<c-d>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-u>", function() return math.ceil(vim.api.nvim_win_get_height(0)/2) .. "<c-u>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-f>", function() return math.ceil(vim.api.nvim_win_get_height(0)/1) .. "<c-d>" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-b>", function() return math.ceil(vim.api.nvim_win_get_height(0)/1) .. "<c-u>" end, {expr = true})
https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim

-- ## insert LF or SP without entering insert mode

vim.keymap.set({"n", "x"}, "<down>", ":put  _<cr>", {silent = true})
vim.keymap.set({"n", "x"}, "<up>",   ":put! _<cr>", {silent = true})
vim.keymap.set({"n", "x"}, "<right>", [["=" "<cr>p]], {silent = true})
vim.keymap.set({"n", "x"}, "<left>",  [["=" "<cr>P]], {silent = true})

-- ## insert single char

vim.keymap.set(
	{"n", "x"},
	"mi",
	function()
		vim.cmd("normal! " .. vim.v.count1 .. "i" .. vim.fn.getcharstr())
	end
)
vim.keymap.set(
	{"n", "x"},
	"ma",
	function()
		vim.cmd("normal! " .. vim.v.count1 .. "a" .. vim.fn.getcharstr())
	end
)
-- https://github.com/rjayatilleka/vim-insert-char
-- https://github.com/bagohart/vim-insert-append-single-character

-- ## operator mode { and } should default to linewise

vim.keymap.set(
	"o",
	"{",
	function()
		local mode = vim.api.nvim_get_mode().mode
		local vis_mode
		if mode == "no"    then vis_mode = "V"     end
		if mode == "nov"   then vis_mode = "v"     end
		if mode == "noV"   then vis_mode = "V"     end
		if mode == "no\22" then vis_mode = "<c-v>" end
		local cache_selection = vim.o.selection
		vim.o.selection = "exclusive"
		vim.schedule(function()
			vim.o.selection = cache_selection
		end)
		return "<cmd>normal! " .. vis_mode .. vim.v.count1 .. "{<cr>"
	end,
	{
		expr = true
	}
)
vim.keymap.set(
	"o",
	"}",
	function()
		local mode = vim.api.nvim_get_mode().mode
		local vis_mode
		if mode == "no"    then vis_mode = "V"     end
		if mode == "nov"   then vis_mode = "v"     end
		if mode == "noV"   then vis_mode = "V"     end
		if mode == "no\22" then vis_mode = "<c-v>" end
		local cache_selection = vim.o.selection
		vim.o.selection = "exclusive"
		vim.schedule(function()
			vim.o.selection = cache_selection
		end)
		return "<cmd>normal! " .. vis_mode .. vim.v.count1 .. "}<cr>"
	end,
	{
		expr = true
	}
)

-- ## insert mode completion

vim.keymap.set("i", "<down>", "<c-n>")
vim.keymap.set("i", "<up>",   "<c-p>")
vim.keymap.set("i", "<c-n>",  "<down>")
vim.keymap.set("i", "<c-p>",  "<up>")

--]=]
