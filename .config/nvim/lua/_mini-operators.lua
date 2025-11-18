require("mini.deps").add({
	source = "nvim-mini/mini.operators",
})

require("mini.operators").setup({
	replace = {
		-- prefix = "s",
		prefix = "",
		reindent_linewise = false,
	},
})
