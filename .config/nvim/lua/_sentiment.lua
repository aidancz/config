vim.g.loaded_matchparen = 1
vim.o.showmatch = false

require("mini.deps").add({
	-- source = "utilyre/sentiment.nvim",
	source = "ofseed/sentiment.nvim",
})

require("sentiment").setup({
	included_buftypes = {
		[""] = false,
	},
	excluded_filetypes = {
	},
	included_modes = {
		n = true,
		i = true,
	},
	delay = 0,
	pairs = {
		{ "(", ")" },
		{ "[", "]" },
		{ "{", "}" },
		-- { "<", ">" },
	},
})
