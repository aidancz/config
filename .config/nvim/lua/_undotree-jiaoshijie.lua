require("mini.deps").add({
	source = "jiaoshijie/undotree",
	depends = {
		{
			source = "nvim-lua/plenary.nvim",
		},
	},
})

require("undotree").setup({
	position = "right",
	window = {
		winblend = 0,
	},
})

vim.api.nvim_set_hl(0, "UndotreeDiffAdded",   {link = "nofrils-green"})
vim.api.nvim_set_hl(0, "UndotreeDiffRemoved", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "UndotreeDiffLine",    {link = "nofrils-blue"})

vim.keymap.set("n", "<c-s-u>", require('undotree').toggle)
