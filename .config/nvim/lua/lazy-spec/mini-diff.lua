return
{
	"echasnovski/mini.diff",
	version = false,
	config = function()
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
				apply = "ga",
				reset = "gr",
				textobject = "gh",
			},
		})
		vim.api.nvim_set_hl(0, "MiniDiffOverChange", {link = "nofrils-yellow"})
		vim.api.nvim_set_hl(0, "MiniDiffOverContext", {link = "nofrils-default"})
	end,
}
