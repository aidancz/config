require("hls").setup()

vim.keymap.set(
	{"n", "x"},
	"<leader>s",
	function()
		vim.o.operatorfunc = [[v:lua.require'hls'.hl]]
		return "g@"
	end,
	{
		expr = true,
	}
)
vim.keymap.set("n", "<leader>ss", "<leader>s_", {remap = true})
vim.keymap.set("n", "<leader>S", "<leader>s$", {remap = true})

vim.keymap.set(
	{"n", "x"},
	"e",
	function()
		vim.o.operatorfunc = [[v:lua.require'hls'.hl_not]]
		return "g@"
	end,
	{
		expr = true,
	}
)

vim.keymap.set(
	{"n", "x"},
	"<del>",
	function()
		vim.o.operatorfunc = [[v:lua.require'hls'.hl_tog]]
		return "g@"
	end,
	{
		expr = true,
	}
)

require("luaexec").add_mode({
	name = "hls",
	chunks = {
		{
			code = [[]],
		},
	},
})
