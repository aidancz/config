require("macro").setup()

require("luaexec").add_mode({
	name = "macro",
	chunks = {
		{
			code = [[require("macro").record_play()]],
			lkey = {"n", "r"},
		},
		{
			code = [[require("macro").idx_next()]],
			lkey = {"n", "m"},
		},
		{
			code = [[require("macro").idx_reg()]],
		},
		{
			code = [[require("macro").record_edit()]],
		},
	},
})

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
