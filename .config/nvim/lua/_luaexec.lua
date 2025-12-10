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
	code = [[return vim.v.searchforward == 1 and "n" or "N"]],
	from = "search",
	name = "next",
})
require("luaexec").add({
	code = [[return vim.v.searchforward == 1 and "N" or "n"]],
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
