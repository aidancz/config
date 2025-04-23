-- require("mini.deps").add({
-- 	source = "aidancz/lfsp.nvim",
-- })

vim.keymap.set(
	{"n", "x", "o"},
	"<down>",
	function()
		return
		require("lf").expr({
			direction = "next",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	{"n", "x", "o"},
	"<up>",
	function()
		return
		require("lf").expr({
			direction = "prev",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	{"n", "x", "o"},
	"<left>",
	function()
		return
		require("sp").expr({
			direction = "prev",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	{"n", "x", "o"},
	"<right>",
	function()
		return
		require("sp").expr({
			direction = "next",
			follow = true,
		})
	end,
	{expr = true}
)
