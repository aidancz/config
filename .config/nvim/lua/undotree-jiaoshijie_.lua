vim.pack.add({
	"https://github.com/jiaoshijie/undotree",
	"https://github.com/nvim-lua/plenary.nvim",
})

require("undotree").setup({
	position = "right",
	window = {
		winblend = 0,
	},
})

vim.api.nvim_set_hl(0, "UndotreeDiffAdded",   {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "UndotreeDiffRemoved", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "UndotreeDiffLine",    {link = "nofrils_blue"})

vim.keymap.set("n", "fu", require("undotree").toggle)
