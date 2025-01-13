require("mini.deps").add({
	source = "nullromo/go-up.nvim",
})

require("go-up").setup({
})

vim.keymap.set({"n", "v"}, "zz", require("go-up").centerScreen)
