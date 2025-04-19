require("macro").setup()

require("modexec").add_mode({
	name = "macro",
	chunks = {
		{
			code = [[require("macro").record_play()]],
			key = {"n", "r"},
		},
		{
			code = [[require("macro").idx_next()]],
			key = {"n", "m"},
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
		require("modexec").set_current_mode("macro")
		if vim.fn.reg_recording() == "" then
			return [[<cmd>lua require("macro").record_start()<cr>]]
		else
			return "q"
		end
	end,
	{expr = true}
)
