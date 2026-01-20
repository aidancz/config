vim.keymap.set(
	{"n", "x"},
	"<space>C",
	function()
		vim.o.operatorfunc = [[v:lua.require'comment-multiply'.operatorfunc]]
		return "g@"
	end,
	{
		expr = true,
	}
)
vim.keymap.set(
	{"n", "x"},
	"<space>B",
	function()
		vim.o.operatorfunc = [[v:lua.require'comment-multiply'.operatorfunc_block]]
		return "g@"
	end,
	{
		expr = true,
	}
)
