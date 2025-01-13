require("mini.deps").add({
	source = "mikavilpas/yazi.nvim",
})

require("yazi").setup({})

vim.api.nvim_create_user_command("Yazi", function() require("yazi").yazi() end, {})
