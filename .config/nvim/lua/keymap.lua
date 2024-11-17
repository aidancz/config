--[[
:h map-table

         Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
Command        +------+-----+-----+-----+-----+-----+------+------+
[nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
[nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |

:h key-notation
--]]



-- # leader key

vim.g.mapleader = " "
vim.g.maplocalleader = " "



-- # disable key

vim.keymap.set({"n", "x", "o"}, "<space>", "<nop>")

vim.keymap.set({"n", "x", "o"}, "f", "<nop>")
vim.keymap.set({"n", "x", "o"}, "F", "<nop>")
vim.keymap.set({"n", "x", "o"}, "t", "<nop>")
vim.keymap.set({"n", "x", "o"}, "T", "<nop>")
vim.keymap.set({"n", "x", "o"}, ";", "<nop>")
vim.keymap.set({"n", "x", "o"}, ",", "<nop>")



-- # "n"

-- vim.keymap.set("n", "<down>", ":put  _<cr>", {silent = true})
-- vim.keymap.set("n", "<up>",   ":put! _<cr>", {silent = true})
-- vim.keymap.set("n", "<left>",  [["=" "<cr>P]], {silent = true})
-- vim.keymap.set("n", "<right>", [["=" "<cr>p]], {silent = true})

-- vim.keymap.set("n", "<f3>", "gO", {remap = true})

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



-- # "i"

vim.keymap.set("i", "<down>", "<c-n>")
vim.keymap.set("i", "<up>",   "<c-p>")



-- # "o"

vim.keymap.set("o", "{", function() return "V" .. vim.v.count1 .. "{" end, {silent = true, expr = true})
vim.keymap.set("o", "}", function() return "V" .. vim.v.count1 .. "}" end, {silent = true, expr = true})



-- # {"n", "x"}

vim.keymap.set({"n", "x"}, "j", function()
	return vim.v.count == 0 and "gj" or "j"
	end, {expr = true})
vim.keymap.set({"n", "x"}, "k", function()
	return vim.v.count == 0 and "gk" or "k"
	end, {expr = true})

vim.keymap.set({"n", "x"}, "<c-n>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-e>" end, {silent = true, expr = true})
vim.keymap.set({"n", "x"}, "<c-p>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-y>" end, {silent = true, expr = true})
-- https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim



-- # {"n", "x", "o"}

vim.keymap.set({"n", "x", "o"}, ";",     "<cmd>normal @:<cr>")
vim.keymap.set({"n", "x", "o"}, ",",     "<cmd>normal @q<cr>")
vim.keymap.set({"n", "x", "o"}, "<f24>", "<cmd>normal @q<cr>")
vim.keymap.set({"n", "x", "o"}, "<f13>", "<cmd>normal @p<cr>")



-- # {"n", "x", "i"}

vim.keymap.set({"n", "x", "i"}, "<c-s>", "<cmd>normal zz<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-j>", "<cmd>normal zt<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-k>", "<cmd>normal zb<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-h>", "<cmd>normal zz<c-n><cr>", {remap = true})
vim.keymap.set({"n", "x", "i"}, "<c-l>", "<cmd>normal zz<c-p><cr>", {remap = true})
vim.keymap.set({"i", "c"}, "<a-v>", "<c-k>")

vim.keymap.set({"n", "x", "i"}, "<f1>", "<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>")
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

vim.keymap.set({"n", "x", "i"}, "<f12>", "<cmd>q!<cr>")



-- # digraph

vim.fn.digraph_set("oo", "●")
vim.fn.digraph_set("xx", "×")
vim.fn.digraph_set("-<", "←")
vim.fn.digraph_set("-^", "↑")
vim.fn.digraph_set("^v", "↕")



-- # map to commands

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



vim.api.nvim_create_user_command("DeleteLastEOL",
	function()
		vim.opt.binary = true
		vim.opt.fixendofline = false
		vim.opt.endofline = false
	end,
	{})
-- https://stackoverflow.com/questions/1050640/how-to-stop-vim-from-adding-a-newline-at-end-of-file
