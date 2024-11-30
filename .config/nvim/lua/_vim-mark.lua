MiniDeps.add({
	source = "inkarkat/vim-mark",
	depends = {
		{
			source = "inkarkat/vim-ingo-library",
		},
	},
})

vim.api.nvim_set_hl(0, "MarkWord1", {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "MarkWord2", {link = "nofrils-green-bg"})
vim.api.nvim_set_hl(0, "MarkWord3", {link = "nofrils-cyan-bg"})
vim.api.nvim_set_hl(0, "MarkWord4", {link = "nofrils-red-bg"})
vim.api.nvim_set_hl(0, "MarkWord5", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "MarkWord6", {link = "nofrils-yellow-bg"})
