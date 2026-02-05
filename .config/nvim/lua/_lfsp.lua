vim.opt.runtimepath:prepend("~/sync_git/lfsp.nvim")

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
	"<c-u>",
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
	"<c-r>",
	function()
		return
		require("sp").expr({
			direction = "prev",
			follow = true,
		})
	end,
	{expr = true}
)
