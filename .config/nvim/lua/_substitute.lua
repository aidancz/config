require("mini.deps").add({
	source = "gbprod/substitute.nvim",
	depends = {
		{
			source = "gbprod/yanky.nvim",
		},
	},
})

require("substitute").setup({
	on_substitute = require("yanky.integration").substitute(),
	highlight_substituted_text = {
		enabled = false,
	},
})

vim.keymap.set("n", "<tab>", require("substitute").operator)
vim.keymap.set("x", "<tab>", require("substitute").visual)
