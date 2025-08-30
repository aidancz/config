require("mini.deps").add({
	source = "nvim-mini/mini.splitjoin",
})

require("mini.splitjoin").setup({
	mappings = {
		toggle = "gS",
	},
})
