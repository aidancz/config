vim.pack.add({
	"https://github.com/ghostbuster91/nvim-next",
})

require("nvim-next").setup({
	default_mappings = {
		repeat_style = "original",
	},
	items = {
		require("nvim-next/builtins").f,
		require("nvim-next/builtins").t,
	},
})
