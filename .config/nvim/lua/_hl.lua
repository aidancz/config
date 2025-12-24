require("hl").setup()

vim.keymap.set(
	{"n", "x"},
	"<space>v",
	function()
		vim.o.operatorfunc = [[v:lua.require'hl'.hl_tog]]
		return "g@"
	end,
	{
		expr = true,
	}
)
