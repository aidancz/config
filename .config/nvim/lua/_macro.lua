require("macro").setup()

vim.keymap.set(
	"n",
	"q",
	function()
		require("modal_execution").set_current_mode("macro")
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

require("modal_execution").add_mode({
	name = "macro",
	config1 = {
	},
	func = function(self, config2)
		local config0 = {
			slot_index = 1,
		}
		local config1 = self.config1 or {}
		local config2 = config2 or {}
		local config = vim.tbl_extend(
			"force",
			config0,
			config1,
			config2
		)
		require("macro").set_idx(config.slot_index)
		require("macro").record_play()
	end,
	setup = function(self)
		vim.keymap.set("n", "r", function() self:func({slot_index = 1}) end)
		vim.keymap.set("n", "m", function() self:func({slot_index = 2}) end)
	end,
})
