require("mini.deps").add({
	source = "folke/snacks.nvim",
})

require("snacks").setup({
	picker = {
		enabled = true,
		ui_select = false,
	},
	scratch = {
		enabled = true,
	},
	lazygit = {
		enabled = true,
	},
})
