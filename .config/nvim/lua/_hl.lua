require("hl").setup()

vim.keymap.set(
	{"n", "x"},
	"<leader>x",
	function()
		vim.o.operatorfunc = [[v:lua.require'hl'.hl_tog]]
		return "g@"
	end,
	{
		expr = true,
	}
)
vim.keymap.set("n", "<leader>xx", "<leader>x_", {remap = true})
vim.keymap.set("n", "<leader>X", "<leader>x$", {remap = true})
