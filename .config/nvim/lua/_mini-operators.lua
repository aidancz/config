require("mini.deps").add({
	source = "echasnovski/mini.operators",
})

require("mini.operators").setup({
	replace = {
		-- prefix = "s",
		prefix = "",
		reindent_linewise = false,
	},
})

-- vim.keymap.set("n", "S", "s$", {remap = true})
