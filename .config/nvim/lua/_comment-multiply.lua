vim.keymap.set(
	{"n", "x"},
	",c",
	function()
		vim.o.operatorfunc = [[v:lua.require'comment-multiply'.operatorfunc]]
		return "g@"
	end,
	{
		expr = true,
	}
)
