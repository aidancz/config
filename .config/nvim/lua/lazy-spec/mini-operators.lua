return
{
	"echasnovski/mini.operators",
	version = false,
	config = function()
		require("mini.operators").setup({
			replace = {
				prefix = "s",
				reindent_linewise = false,
			},
		})
		vim.keymap.set("n", "S", "s$", {remap = true})
	end,
}
