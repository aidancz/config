return
{
	"mikavilpas/yazi.nvim",
	config = function()
		require("yazi").setup({})
		vim.api.nvim_create_user_command("Yazi", function() require("yazi").yazi() end, {})
	end,
}