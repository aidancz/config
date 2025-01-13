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



-- # disable key

vim.keymap.set({"n", "x", "o"}, "<space>", "<nop>")



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
vim.keymap.set("i", "<c-n>",  "<down>")
vim.keymap.set("i", "<c-p>",  "<up>")

vim.keymap.set("i", "<left>",  "<c-g>U<left>")
vim.keymap.set("i", "<right>", "<c-g>U<right>")



-- # "o"

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

vim.keymap.set({"n", "x"}, ";", "@:")



-- # {"n", "x", "i"}

vim.keymap.set({"n", "x", "i"}, "<c-s>", "<cmd>normal zz<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-j>", "<cmd>normal zt<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-k>", "<cmd>normal zb<cr>")
vim.keymap.set({"n", "x", "i"}, "<c-h>", "<cmd>normal zz<c-n><cr>", {remap = true})
vim.keymap.set({"n", "x", "i"}, "<c-l>", "<cmd>normal zz<c-p><cr>", {remap = true})
vim.keymap.set({"i", "c"}, "<a-v>", "<c-k>")

vim.keymap.set({"n", "x", "i"}, "<f1>", "<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>")
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

vim.keymap.set({"n", "x", "i"}, "<f12>", function()
	if vim.fn.winnr("$") ~= 1 then
		vim.cmd("close")
	else
		vim.cmd("quit!")
	end
	end)
-- `:q` ignore help window, so create this mapping, see `:h edit-window`
-- https://vi.stackexchange.com/questions/9479/what-is-the-difference-between-quit-and-close-commands



-- # {"n", "x", "o"}

vim.keymap.set({"n", "x", "o"}, "<s-cr>", "-")



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
			vim.keymap.set("n", "n", "nzz", {remap = true})
			vim.keymap.set("n", "N", "Nzz", {remap = true})
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



vim.api.nvim_create_user_command("Presentation",
	function()
		vim.opt.foldcolumn = "0"

		vim.opt.signcolumn = "no"

		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
	{})
