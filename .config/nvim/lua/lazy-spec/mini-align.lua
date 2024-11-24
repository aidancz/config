return
{
	"echasnovski/mini.align",
	version = false,
	config = function()
		require("mini.align").setup({
			mappings = {
				start = "gn",
				start_with_preview = "gN",
			},
		})
		vim.keymap.set("n", "gnn", "gn_", {remap = true})
	end,
}
