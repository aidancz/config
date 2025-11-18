require("hl").setup()

vim.keymap.set(
	{"n", "x"},
	"mv",
	function()
		vim.o.operatorfunc = [[v:lua.require'hl'.hl_tog]]
		return "g@"
	end,
	{
		expr = true,
	}
)
