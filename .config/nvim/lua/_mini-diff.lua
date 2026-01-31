vim.pack.add({
	"https://github.com/nvim-mini/mini.diff",
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

		goto_first = "",
		goto_prev = "",
		goto_next = "",
		goto_last = "",
	},
})

vim.api.nvim_set_hl(0, "MiniDiffOverChange", {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniDiffOverContext", {link = "nofrils_default"})

require("luaexec").add({
	code = [[require("mini.diff").goto_hunk("prev")]],
	from = "mini.diff",
	name = "prev",
})

require("luaexec").add({
	code = [[require("mini.diff").goto_hunk("next")]],
	from = "mini.diff",
	name = "next",
})
