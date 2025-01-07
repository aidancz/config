MiniDeps.add({
	source = "echasnovski/mini.indentscope",
})

require("mini.indentscope").setup({
	draw = {
		delay = 0,
		animation = require("mini.indentscope").gen_animation.none(),
	},
	mappings = {
		object_scope = "",
		object_scope_with_border = "",
		goto_top = "",
		goto_bottom = "",
	},
	options = {
		border = "top",
		indent_at_cursor = true,
		try_as_border = false,
	},
	symbol = "┃",
})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", {link = "nofrils-yellow"})
