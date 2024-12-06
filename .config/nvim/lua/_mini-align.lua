MiniDeps.add({
	source = "echasnovski/mini.align",
})

require("mini.align").setup({
	-- silent = true,
	mappings = {
		start = "gn",
		start_with_preview = "gN",
	},
})
vim.keymap.set("n", "gnn", "gn_", {remap = true})
