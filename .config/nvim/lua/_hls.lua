require("hls").setup()

vim.keymap.set(
	{"n", "x"},
	"<space>V",
	function()
		vim.o.operatorfunc = [[v:lua.require'hls'.hl_tog]]
		return "g@"
	end,
	{
		expr = true,
	}
)
