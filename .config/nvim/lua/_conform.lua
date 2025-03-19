require("mini.deps").add({
	source = "stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = {
			"stylua",
		},
	},
})
