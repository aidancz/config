require("mini.deps").add({
	source = "nvim-mini/mini.indentscope",
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
		border = "both",
		indent_at_cursor = true,
		try_as_border = false,
	},
	symbol = "┃",
})

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", {link = "nofrils_yellow"})

-- vim.api.nvim_create_augroup("mini_indentscope_config", {clear = true})
-- vim.api.nvim_create_autocmd(
-- 	"BufEnter",
-- 	{
-- 		group = "mini_indentscope_config",
-- 		pattern = "*",
-- 		callback = function()
-- 			if vim.bo.buftype ~= "" then
-- 				vim.b.miniindentscope_disable = true
-- 			end
-- 		end,
-- 	}
-- )

vim.g.miniindentscope_disable = true
