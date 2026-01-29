vim.keymap.set(
	{"n", "x", "o"},
	"m/",
	function()
		return
		require("tT").expr({
			direction = "next",
		})
	end,
	{expr = true}
)
vim.keymap.set(
	{"n", "x", "o"},
	"m?",
	function()
		return
		require("tT").expr({
			direction = "prev",
		})
	end,
	{expr = true}
)
