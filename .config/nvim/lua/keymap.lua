-- # vim.fn.digraph_set

vim.fn.digraph_set("oo", "●")
vim.fn.digraph_set("xx", "×")
vim.fn.digraph_set("-<", "←")
vim.fn.digraph_set("-^", "↑")
vim.fn.digraph_set("^v", "↕")

-- # vim.keymap.set

--[[
:h vim-modes
:h map-table
- normal:           n
- visual:           x
- select:           s
- insert:           i
- cmdline:          c
- terminal:         t
- operator-pending: o

:h key-notation

to sort these lines, use:
'<,'>SortRangesByHeader /vim.keymap.set/

https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim
--]]

-- vim.keymap.set("i", "<c-n>",  "<down>")
-- vim.keymap.set("i", "<c-p>",  "<up>")
-- vim.keymap.set("i", "<down>", "<c-n>")
-- vim.keymap.set("i", "<up>",   "<c-p>")
-- vim.keymap.set("n", "<down>", ":put  _<cr>", {silent = true})
-- vim.keymap.set("n", "<f3>", "gO", {remap = true})
-- vim.keymap.set("n", "<left>",  [["=" "<cr>P]], {silent = true})
-- vim.keymap.set("n", "<right>", [["=" "<cr>p]], {silent = true})
-- vim.keymap.set("n", "<up>",   ":put! _<cr>", {silent = true})
-- vim.keymap.set({"n", "x", "o"}, "<a-e>",   "ge")
-- vim.keymap.set({"n", "x", "o"}, "<a-s-e>", "gE")
-- vim.keymap.set({"n", "x", "o"}, "<a-s-w>", "B")
-- vim.keymap.set({"n", "x", "o"}, "<a-w>",   "b")
-- vim.keymap.set({"n", "x"}, "<bs>", ":<up><cr>")
-- vim.keymap.set({"n", "x"}, "<bs>", "@:")
-- vim.keymap.set({"n", "x"}, "<c-b>", function() return math.ceil(vim.api.nvim_win_get_height(0)/1) .. "<c-u>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-d>", function() return math.ceil(vim.api.nvim_win_get_height(0)/2) .. "<c-d>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-e>", function() return 1                                           .. "<c-d>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-f>", function() return math.ceil(vim.api.nvim_win_get_height(0)/1) .. "<c-d>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-n>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-d>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-p>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-u>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-u>", function() return math.ceil(vim.api.nvim_win_get_height(0)/2) .. "<c-u>" end, {expr = true})
-- vim.keymap.set({"n", "x"}, "<c-y>", function() return 1                                           .. "<c-u>" end, {expr = true})
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
vim.keymap.set(
	"n",
	"N",
	function()
		if vim.v.searchforward == 1 then
			return "N"
		else
			return "n"
		end
	end,
	{
		expr = true,
		desc =
[[
https://vi.stackexchange.com/questions/2365/how-can-i-get-n-to-go-forward-even-if-i-started-searching-with-or
]],
	}
)
vim.keymap.set(
	"n",
	"n",
	function()
		if vim.v.searchforward == 1 then
			return "n"
		else
			return "N"
		end
	end,
	{
		expr = true,
		desc =
[[
https://vi.stackexchange.com/questions/2365/how-can-i-get-n-to-go-forward-even-if-i-started-searching-with-or
]],
	}
)
vim.keymap.set(
	"n",
	[[\]],
	function()
		vim.cmd("normal! " .. vim.v.count1 .. "i" .. vim.fn.getcharstr())
	end,
	{
		desc =
[[
https://github.com/rjayatilleka/vim-insert-char
https://github.com/bagohart/vim-insert-append-single-character
]],
	}
)
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
	{expr = true}
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
	{expr = true}
)
vim.keymap.set(
	{"n", "x", "i"},
	"<a-cr>",
	"<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>",
	{
		desc =
[[
https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently
]],
	}
)
vim.keymap.set(
	{"n", "x", "i"},
	"<f13>",
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
	end,
	{
		desc =
[[
`:q` ignore help window, so create this mapping, see `:h edit-window`
https://vi.stackexchange.com/questions/9479/what-is-the-difference-between-quit-and-close-commands
]],
	}
)
vim.keymap.set(
	{"n", "x", "i"},
	"<c-esc>",
	function()
		vim.cmd("qa!")
	end
)
vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<c-bs>",
	function() vim.cmd(vim.fn.histget("cmd", -1)) end
)
vim.keymap.set(
	{"n", "x"},
	"<bs>",
	function() vim.cmd(vim.fn.histget("cmd", -1)) end
)
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
vim.keymap.set("i", "<left>",  "<c-g>U<left>")
vim.keymap.set("i", "<right>", "<c-g>U<right>")
vim.keymap.set("n", "-", "<c-r><plug>(redrawstatus)")
vim.keymap.set("n", "<c-i>", "<c-i>")
vim.keymap.set("n", "<c-m>", "<c-m>")
vim.keymap.set("n", "<plug>(redrawstatus)", function() vim.cmd("redrawstatus") end)
vim.keymap.set("n", "g/", "q/")
vim.keymap.set("n", "g:", "q:")
vim.keymap.set("n", "g?", "q?")
vim.keymap.set("n", "gk", "m")
vim.keymap.set("n", "u", "u<plug>(redrawstatus)")
vim.keymap.set({"i", "c"}, "<c-s-v>", "<c-k>")
vim.keymap.set({"n", "x", "i"}, "<c-h>", "<cmd>normal zz<plug>(quarter-e)<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-j>", "<cmd>normal zt<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-k>", "<cmd>normal zb<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-l>", "<cmd>normal zz<plug>(quarter-y)<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-s>", "<cmd>normal zz<cr>")
vim.keymap.set({"n", "x", "i"}, "<plug>(quarter-e)", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-e>" end, {expr = true})
vim.keymap.set({"n", "x", "i"}, "<plug>(quarter-y)", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-y>" end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "<s-cr>", "-")
vim.keymap.set({"n", "x", "o"}, "<space>", "<nop>")
vim.keymap.set({"n", "x", "o"}, "f", "<nop>")
vim.keymap.set({"n", "x", "o"}, "m", "<nop>")
vim.keymap.set({"n", "x", "o"}, "r", "<nop>")
vim.keymap.set({"n", "x"}, "|", "r")

-- # luaexec

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

---

require("luaexec").add({
	code =
[=[
vim.cmd([[
let @+ = @"
let @* = @"
]])
]=],
	name = "register_transfer",
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

---

require("luaexec").add({
	code =
[=[
vim.cmd([[%s/\s\+$//e]])
]=],
	name = "trail_remove",
	desc =
[[
https://vim.fandom.com/wiki/Remove_unwanted_spaces
]],
})

---

require("luaexec").add({
	code =
[[
vim.opt.binary = true
vim.opt.fixendofline = false
vim.opt.endofline = false
]],
	name = "last_eol_remove",
	desc =
[[
https://stackoverflow.com/questions/1050640/how-to-stop-vim-from-adding-a-newline-at-end-of-file
]],
})

---

require("luaexec").add({
	code = [[vim.cmd("%!cat -s")]],
	name = "multiple_blank_lines_deduplicate",
	desc =
[[
https://unix.stackexchange.com/questions/12812/replacing-multiple-blank-lines-with-a-single-blank-line-in-vim-sed
]],
})

---

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
