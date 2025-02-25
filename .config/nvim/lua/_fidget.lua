require("mini.deps").add({
	source = "j-hui/fidget.nvim",
})

require("fidget").setup({
	notification = {
		poll_rate = 100,
		override_vim_notify = true,
		configs = {
			default = vim.tbl_extend(
				"force",
				require("fidget.notification").default_config,
				{
					icon = "❰❰",
					update_hook = false,
				}
			)
			-- https://github.com/j-hui/fidget.nvim/issues/162
		},
		window = {
			x_padding = 0,
		},
	},
})
