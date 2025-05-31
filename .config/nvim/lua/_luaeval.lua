require("luaeval").setup({
	hook_open = function()
	end,
	hook_close = function()
	end,
})

require("luaexec").add({
	code = [[require("luaeval").toggle()]],
	from = "luaeval",
	name = "window",
	keys = {"n", "ri"},
})

require("luaexec").add({
	code = [[require("luaeval").eval()]],
	from = "luaeval",
	keys = {"n", "m<bs>"},
})

require("luaexec").add({
	code = [[require("luaeval").eval("vim.print")]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval("vim.cmd")]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval("vim.cmd.normal")]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval("vim.api.nvim_feedkeys")]],
	from = "luaeval",
})
