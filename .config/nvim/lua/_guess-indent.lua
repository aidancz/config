vim.pack.add({
	"https://github.com/NMAC427/guess-indent.nvim",
})

require("guess-indent").setup({
	auto_cmd = true,
	on_tab_options = {
		expandtab = false,
	},
	on_space_options = {
		expandtab = true,
		tabstop = "detected",
		softtabstop = "detected",
		shiftwidth = "detected",
	},
})
