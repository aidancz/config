require("mini.deps").add({
	source = "gbprod/yanky.nvim",
})

require("yanky").setup({
	highlight = {
		on_put = false,
		on_yank = false,
	},
})

-- vim.keymap.set({"n", "x"}, "y", "<plug>(YankyYank)")

require("luaexec").add_mode({
	name = "yanky",
	chunks = {
		{
			code = [[require("yanky").cycle(1)]],
			name = "prev",
			gkey = {{"n", "x"}, "<c-up>"},
		},
		{
			code = [[require("yanky").cycle(-1)]],
			name = "next",
			gkey = {{"n", "x"}, "<c-down>"},
		},
		{
			code = [[require("yanky.picker").select_in_history()]],
			name = "history",
		},
	},
})
