vim.g.loaded_matchparen = 1
vim.opt.showmatch = false

MiniDeps.add({
	source = "utilyre/sentiment.nvim",
})

require("sentiment").setup({
	included_modes = {
		n = true,
		i = true,
	},
	delay = 0,
})
