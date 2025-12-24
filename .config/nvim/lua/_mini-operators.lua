require("mini.deps").add({
	source = "nvim-mini/mini.operators",
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
		prefix = "",
		reindent_linewise = false,
	},
	sort = {
		prefix = "<space>s",
	},
})
