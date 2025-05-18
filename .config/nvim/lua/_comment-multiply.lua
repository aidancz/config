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
vim.keymap.set("n", ",cc", ",c_", {remap = true})
vim.keymap.set("n", ",C", ",c$", {remap = true})
