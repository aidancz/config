require("macro").setup()

vim.keymap.set(
	"n",
	"q",
	function()
		require("luaexec").set_current_mode("macro")
		if vim.fn.reg_recording() == "" then
			return [[<cmd>lua require("macro").record_start()<cr>]]
		else
			return "q"
		end
	end,
	{expr = true}
)

require("luaexec").add({
	code = [[require("macro").record_play()]],
	from = "macro",
	lkey = {"n", "r"},
})

require("luaexec").add({
	code = [[require("macro").idx_next()]],
	from = "macro",
	lkey = {"n", "m"},
})

require("luaexec").add({
	code = [[require("macro").idx_reg()]],
	from = "macro",
})

require("luaexec").add({
	code = [[require("macro").record_edit()]],
	from = "macro",
})
