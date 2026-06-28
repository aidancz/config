vim.pack.add({
	"https://github.com/nvim-mini/mini.operators",
})

require("mini.operators").setup({
	evaluate = {
		prefix = "<space>e",
	},
	exchange = {
		prefix = "<space>x",
	},
	multiply = {
		prefix = "t",
	},
	replace = {
		prefix = "x",
		reindent_linewise = false,
	},
	sort = {
		prefix = "<space>o",
	},
})
