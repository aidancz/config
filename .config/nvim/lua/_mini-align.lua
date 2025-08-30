require("mini.deps").add({
	source = "nvim-mini/mini.align",
})

require("mini.align").setup({
	-- silent = true,
	mappings = {
		start = "gl",
		start_with_preview = "gL",
	},
})

vim.keymap.set("n", "gll", "gl_", {remap = true})
