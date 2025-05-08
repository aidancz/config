require("hl").setup()

vim.keymap.set(
	{"n", "x"},
	"<leader>x",
	require("hl").expr,
	{
		expr = true,
	}
)
vim.keymap.set("n", "<leader>xx", "<leader>x_", {remap = true})
vim.keymap.set("n", "<leader>X", "<leader>x$", {remap = true})

require("luaexec").add_mode({
	name = "hl",
	chunks = {
		{
			code = [[require("hl").del_extmark()]],
		},
	},
})
