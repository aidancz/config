-- # a example of using luaexec

require("luaexec").add({
	code = [[print_time()]],
	from = "example",
	name = "print_time",
	desc = "print the current time with microsecond precision",
	keys = {"n", "<c-s-t>"},
})

--[[
node.code: required
node.from: optional
node.name: optional
node.desc: optional
node.keys: optional
--]]

require("luaexec").add({
	code = [[vim.notify(tostring(vim.v.count))]],
	from = "example",
})

-- # setup nextprev

-- https://github.com/neovim/neovim/issues/1960

require("luaexec").add({
	code =
[=[
local zz = [[<cmd>lua require("go-up").recenter(vim.api.nvim_win_get_height(0) * (2 / 4))<cr>]]
local nzz = "n" .. zz
local Nzz = "N" .. zz
if vim.v.searchforward == 1 then
	return nzz
else
	return Nzz
end
]=],
	from = "search",
	name = "next",
})
require("luaexec").add({
	code =
[=[
local zz = [[<cmd>lua require("go-up").recenter(vim.api.nvim_win_get_height(0) * (2 / 4))<cr>]]
local nzz = "n" .. zz
local Nzz = "N" .. zz
if vim.v.searchforward == 1 then
	return Nzz
else
	return nzz
end
]=],
	from = "search",
	name = "prev",
})

require("luaexec").np_update0()

vim.keymap.set(
	{"n", "x", "o"},
	"n",
	function()
		require("luaexec").np_update2()
		require("luaexec").np_node_exec(
			require("luaexec").np_group.next
		)
	end
)
vim.keymap.set(
	{"n", "x", "o"},
	"b",
	function()
		require("luaexec").np_update2()
		require("luaexec").np_node_exec(
			require("luaexec").np_group.prev
		)
	end
)
