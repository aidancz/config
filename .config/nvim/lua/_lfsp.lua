-- require("mini.deps").add({
-- 	source = "aidancz/lfsp.nvim",
-- })

vim.keymap.set(
	"n",
	"u",
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
	"n",
	"r",
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
	"n",
	"U",
	function()
		return
		require("sp").expr({
			direction = "next",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	"n",
	"R",
	function()
		return
		require("sp").expr({
			direction = "prev",
			follow = true,
		})
	end,
	{expr = true}
)
