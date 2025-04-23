-- require("mini.deps").add({
-- 	source = "aidancz/tT.nvim",
-- })

vim.keymap.set(
	{"n", "x", "o"},
	"t",
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
	"T",
	function()
		return
		require("tT").expr({
			direction = "prev",
		})
	end,
	{expr = true}
)
