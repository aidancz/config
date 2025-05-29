require("mini.deps").add({
	source = "nvimtools/hydra.nvim",
})

require("hydra").setup({
	hint = false,
})

require("hydra")({
	body = "z",
	heads = {
		{"h", "5zh"},
		{"l", "5zl"},
	},
})
