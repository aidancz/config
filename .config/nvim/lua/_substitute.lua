vim.pack.add({
	"https://github.com/gbprod/substitute.nvim",
	"https://github.com/gbprod/yanky.nvim",
})

require("substitute").setup({
	on_substitute = require("yanky.integration").substitute(),
	highlight_substituted_text = {
		enabled = false,
	},
})

vim.keymap.set("n", "x", require("substitute").operator)
vim.keymap.set("x", "x", require("substitute").visual)
