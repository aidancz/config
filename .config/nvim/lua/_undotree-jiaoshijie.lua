MiniDeps.add({
	source = "jiaoshijie/undotree",
	depends = {
		{
			source = "nvim-lua/plenary.nvim",
		},
	},
})

require("undotree").setup({
	window = {
		winblend = 0,
	},
})
vim.keymap.set("n", "<f7>", require('undotree').toggle)
vim.api.nvim_set_hl(0, "UndotreeDiffAdded",   {link = "nofrils-green"})
vim.api.nvim_set_hl(0, "UndotreeDiffRemoved", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "UndotreeDiffLine",    {link = "nofrils-blue"})
