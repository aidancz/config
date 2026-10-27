vim.pack.add({
	"https://github.com/j-hui/fidget.nvim",
})

require("fidget").setup({
	progress = {
		ignore = {
			function(msg)
				return msg.lsp_client.name == "lua_ls" and string.find(msg.title, "Diagnosing")
			end,
		},
		-- https://github.com/j-hui/fidget.nvim/issues/249
	},
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
			normal_hl = "nofrils_white",
			winblend = 0,
			x_padding = 0,
		},
	},
})
