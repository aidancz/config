vim.pack.add({
	"https://github.com/gbprod/yanky.nvim",
})

require("yanky").setup({
	highlight = {
		on_put = false,
		on_yank = false,
	},
})

-- vim.keymap.set({"n", "x"}, "y", "<plug>(YankyYank)")

vim.keymap.set({"n", "x"}, "p", "<plug>(YankyPutAfter)")
vim.keymap.set({"n", "x"}, "P", "<plug>(YankyPutBefore)")

require("luaexec").add({
	code = [[require("yanky").cycle(1)]],
	from = "yanky",
	name = "prev",
	keys = {{"n", "x"}, "<pageup>"},
})

require("luaexec").add({
	code = [[require("yanky").cycle(-1)]],
	from = "yanky",
	name = "next",
	keys = {{"n", "x"}, "<pagedown>"},
})

require("luaexec").add({
	code = [[require("yanky.picker").select_in_history()]],
	from = "yanky",
	name = "history",
})
