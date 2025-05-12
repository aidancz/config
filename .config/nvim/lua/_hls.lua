require("hls").setup()

vim.keymap.set(
	{"n", "x"},
	"<leader>s",
	function()
		vim.o.operatorfunc = [[v:lua.require'hls'.hl_tog]]
		return "g@"
	end,
	{
		expr = true,
	}
)
vim.keymap.set("n", "<leader>ss", "<leader>s_", {remap = true})
vim.keymap.set("n", "<leader>S", "<leader>s$", {remap = true})

require("luaexec").add_mode({
	name = "hls",
	chunks = {
		{
			code = [[]],
		},
	},
})
