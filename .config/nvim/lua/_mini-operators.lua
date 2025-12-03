require("mini.deps").add({
	source = "nvim-mini/mini.operators",
})

require("mini.operators").setup({
	evaluate = {
		prefix = "me",
	},
	exchange = {
		prefix = "mx",
	},
	multiply = {
		prefix = "t",
	},
	replace = {
		prefix = "",
		reindent_linewise = false,
	},
	sort = {
		prefix = "mo",
	},
})
