MiniDeps.add({
	source = "echasnovski/mini.operators",
})

require("mini.operators").setup({
	replace = {
		prefix = "s",
		reindent_linewise = false,
	},
})
vim.keymap.set("n", "S", "s$", {remap = true})
