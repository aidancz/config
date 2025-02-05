require("mini.deps").add({
	source = "nvim-neo-tree/neo-tree.nvim",
	depends = {
		{
			source = "nvim-lua/plenary.nvim",
		},
		{
			source = "MunifTanjim/nui.nvim",
		},
	},
})

require("neo-tree").setup({
})
