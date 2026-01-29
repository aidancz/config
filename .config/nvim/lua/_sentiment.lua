vim.g.loaded_matchparen = 1
vim.o.showmatch = false

vim.pack.add({
	-- "https://github.com/utilyre/sentiment.nvim",
	"https://github.com/ofseed/sentiment.nvim",
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
