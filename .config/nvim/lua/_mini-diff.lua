require("mini.deps").add({
	source = "nvim-mini/mini.diff",
})

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = {add = "┃", change = "●", delete = "━"},
		priority = 1000,
	},
	delay = {
		text_change = 100,
	},
	mappings = {
		apply = "ga",
		reset = "gr",
		textobject = "ih",
	},
})

vim.api.nvim_set_hl(0, "MiniDiffOverChange", {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniDiffOverContext", {link = "nofrils_default"})
