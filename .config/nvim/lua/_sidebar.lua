require("mini.deps").add({
	source = "sidebar-nvim/sidebar.nvim",
})

require("sidebar-nvim").setup({
	open = true,
	side = "right",
	hide_statusline = true,
	sections = {"buffers"},

	buffers = {
	},
})
