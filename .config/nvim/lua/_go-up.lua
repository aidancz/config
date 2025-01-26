vim.opt.runtimepath:prepend("~/sync_git/go-up.nvim")

-- require("mini.deps").add({
-- 	source = "nullromo/go-up.nvim",
-- })

require("go-up").setup({
})

vim.keymap.set({"n", "v"}, "zz", require("go-up").centerScreen)
vim.keymap.set(
	{"n", "v"},
	"zb",
	function()
		vim.cmd("normal! zb")
		require("go-up").redraw()
	end,
	{
		desc = "https://github.com/nullromo/go-up.nvim/issues/9",
	}
)
