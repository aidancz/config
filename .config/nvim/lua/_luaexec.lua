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
