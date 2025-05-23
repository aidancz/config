require("mini.deps").add({
	source = "echasnovski/mini.clue",
})

require("mini.clue").setup({
})

require("luaexec").add({
	code = [[require("mini.clue").delete()]],
	from = "mini.clue",
})
