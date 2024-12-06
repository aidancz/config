MiniDeps.add({
	source = "echasnovski/mini.diff",
})

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = {add = "┃", change = "●", delete = "━"},
		priority = 0,
	},
	delay = {
		text_change = 100,
	},
	mappings = {
		apply = "gh",
		reset = "gH",
		textobject = "gh",
	},
})
vim.api.nvim_set_hl(0, "MiniDiffOverChange", {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "MiniDiffOverContext", {link = "nofrils-default"})
