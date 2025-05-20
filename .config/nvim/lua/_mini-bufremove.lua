require("mini.deps").add({
	source = "echasnovski/mini.bufremove",
})

require("mini.bufremove").setup({
})

require("luaexec").add({
	code = [[require("mini.bufremove").delete()]],
	from = "mini.bufremove",
})
