require("mini.deps").add({
	source = "echasnovski/mini.indentscope",
})

require("mini.indentscope").setup({
	draw = {
		delay = 0,
		animation = require("mini.indentscope").gen_animation.none(),
	},
	mappings = {
		object_scope = "is",
		object_scope_with_border = "as",
		goto_top = "[s",
		goto_bottom = "]s",
	},
	options = {
		border = "both",
		indent_at_cursor = true,
		try_as_border = false,
	},
	symbol = "┃",
})

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", {link = "nofrils-yellow"})

-- local mini_indentscope_augroup = vim.api.nvim_create_augroup("mini_indentscope", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	"BufEnter",
-- 	{
-- 		group = mini_indentscope_augroup,
-- 		pattern = {"*"},
-- 		callback = function()
-- 			if vim.bo.buftype ~= "" then
-- 				vim.b.miniindentscope_disable = true
-- 			end
-- 		end,
-- 	})

vim.g.miniindentscope_disable = true
