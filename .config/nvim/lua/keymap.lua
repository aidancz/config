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
vim.keymap.set({"n", "x", "o"}, "e",       "<nop>")
vim.keymap.set({"n", "x", "o"}, "v",       "<nop>")
vim.keymap.set({"n", "x", "o"}, "m",       "<nop>")

-- ## bypass <c-i> and <tab> conflict, etc

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

-- ## repeat last command

-- vim.keymap.set({"n", "x"}, "<bs>", ":<up><cr>")
-- vim.keymap.set({"n", "x"}, "<bs>", "@:")
vim.keymap.set(
	{"n", "x"},
	"<bs>",
	function() vim.cmd(vim.fn.histget("cmd", -1)) end
)
require("hydra").add({
	mode = {"n", "x", "s", "i", "c", "t", "o"},
	body = "<f2>",
	heads = {
		{
			"<bs>",
			function() vim.cmd(vim.fn.histget("cmd", -1)) end,
		},
	},
})

-- ## open terminal

vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<f2><cr>",
	"<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>"
)
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

-- # {"n", "x", "o"}

-- ## j -> gj, 1j -> 1j, 2j -> 2j...

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

-- ## <s-cr> -> opposite of <cr>

vim.keymap.set({"n", "x", "o"}, "<s-cr>", "-")

vim.keymap.set(
	"i",
	"<s-cr>",
	function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr><cmd>.m.-2<cr>", true, true, true), "n", false)
	end
)

-- ## S -> gg, G -> G

vim.keymap.set({"n", "x", "o"}, "S", "gg")
vim.keymap.set({"n", "x", "o"}, "G", "G")

-- ## n -> search forward, t -> search backward. (the search direction does not depend on the previous search command)

vim.keymap.set({"n", "x", "o"}, "n", function() return vim.v.searchforward == 1 and "n" or "N" end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "t", function() return vim.v.searchforward == 1 and "N" or "n" end, {expr = true})
-- https://vi.stackexchange.com/questions/2365/how-can-i-get-n-to-go-forward-even-if-i-started-searching-with-or

vim.keymap.set({"n", "x", "o"}, "gn", "gn")
vim.keymap.set({"n", "x", "o"}, "gt", "gN")

-- ## mw -> e, mb -> ge, mW -> E, mB -> gE

require("hydra").add({
	mode = {"n", "x"},
	body = "m",
	heads = {
		{"w", "e"},
		{"b", "ge"},
	},
})
vim.keymap.set("o", "mw", "e")
vim.keymap.set("o", "mb", "ge")

require("hydra").add({
	mode = {"n", "x"},
	body = "m",
	heads = {
		{"W", "E"},
		{"B", "gE"},
	},
})
vim.keymap.set("o", "mW", "E")
vim.keymap.set("o", "mB", "gE")

-- ## <c-o> -> <c-o>, <c-x> -> <c-i>

vim.keymap.set({"n", "x"}, "<c-o>", "<c-o>")
vim.keymap.set({"n", "x"}, "<c-x>", "<c-i>")

-- ## u -> u, - -> <c-r>

vim.keymap.set({"n", "x"}, "<plug>(redrawstatus)", function() vim.cmd("redrawstatus") end)
vim.keymap.set({"n", "x"}, "u", "u<plug>(redrawstatus)")
vim.keymap.set({"n", "x"}, "-", "<c-r><plug>(redrawstatus)")

-- ## r -> d

vim.keymap.set({"n", "x"}, "r", "d")

vim.keymap.set("n", "rr", "r_", {remap = true})
vim.keymap.set("n", "R", "r$", {remap = true})

-- ## insert single char (mnemonic: mono)

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

-- ## m<key> -> <key>

vim.keymap.set({"n", "x"}, "mr", "r")
vim.keymap.set({"n", "x"}, "mv", "v")
vim.keymap.set({"n", "x"}, "mm", "m")

-- ## g<key> -> q<key>

vim.keymap.set({"n", "x"}, "g/", "q/")
vim.keymap.set({"n", "x"}, "g:", "q:")
vim.keymap.set({"n", "x"}, "g?", "q?")

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

-- ## buffer next/prev

-- next {{{
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
	keys = {{"n", "x"}, "gj"},
})
-- }}}

-- prev {{{
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
	keys = {{"n", "x"}, "gk"},
})
-- }}}

require("hydra").add({
	mode = {"n", "x"},
	body = "g",
	heads = {
		{
			"j",
			function()
				require("luaexec").registry.buffer.next()
			end,
		},
		{
			"k",
			function()
				require("luaexec").registry.buffer.prev()
			end,
		},
	},
})

-- ## window next/prev

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd w")
]],
	from = "window",
	name = "next",
	keys = {{"n", "x"}, "gl"},
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
	keys = {{"n", "x"}, "gh"},
})

require("hydra").add({
	mode = {"n", "x"},
	body = "g",
	heads = {
		{
			"l",
			function()
				require("luaexec").registry.window.next()
			end,
		},
		{
			"h",
			function()
				require("luaexec").registry.window.prev()
			end,
		},
	},
})

-- ## window scroll

require("hydra").add({
	mode = {"n", "x"},
	body = "z",
	heads = {
		{"l", "8zl"},
		{"h", "8zh"},
	},
})

-- ## window resize

require("hydra").add({
	mode = {"n", "x"},
	body = "<c-w>",
	heads = {
		{"+", "2<c-w>+"},
		{"-", "2<c-w>-"},
	},
})

require("hydra").add({
	mode = {"n", "x"},
	body = "<c-w>",
	heads = {
		{">", "4<c-w>>"},
		{"<", "4<c-w><"},
	},
})

-- ## tab next/prev

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "m",
-- 	heads = {
-- 		{"t", "gt"},
-- 		{"T", "gT"},
-- 	},
-- })

-- ## quickfix next/prev

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "m",
-- 	heads = {
-- 		{"c", "<cmd>cnext<cr>"},
-- 		{"C", "<cmd>cprevious<cr>"},
-- 	},
-- })

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

-- ## cmdline mode <c-w> should ignore iskeyword

vim.keymap.set(
	"c",
	"<c-w>",
	function()
		local cache_iskeyword = vim.bo.iskeyword
		vim.bo.iskeyword = vim.go.iskeyword
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-w>", true, true, true), "n", false)
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
vim.opt.binary = true
vim.opt.fixendofline = false
vim.opt.endofline = false
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
vim.opt_local.foldcolumn = "0"
vim.opt_local.signcolumn = "no"
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.statuscolumn = ""
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

-- ## insert mode completion

vim.keymap.set("i", "<down>", "<c-n>")
vim.keymap.set("i", "<up>",   "<c-p>")
vim.keymap.set("i", "<c-n>",  "<down>")
vim.keymap.set("i", "<c-p>",  "<up>")

--]=]
