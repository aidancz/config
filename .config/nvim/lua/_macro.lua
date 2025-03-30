require("macro").setup()

vim.keymap.set(
	"n",
	"q",
	function()
		if vim.fn.reg_recording() == "" then
			return [[<cmd>lua require("macro").record_start()<cr>]]
		else
			return "q"
		end
	end,
	{expr = true}
)
vim.keymap.set("n", "Q", require("macro").record_play)
vim.keymap.set("n", "<c-q>", require("macro").idx_next)
vim.keymap.set("n", "<a-q>", require("macro").idx_reg)
vim.keymap.set("n", "cq", require("macro").record_edit)
