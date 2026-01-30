vim.pack.add({
	"https://github.com/nvim-mini/mini.bufremove",
})

require("mini.bufremove").setup({
})

require("luaexec").add({
	code = [[require("mini.bufremove").delete()]],
	from = "mini.bufremove",
	keys = {"n", "<f13>"},
})
