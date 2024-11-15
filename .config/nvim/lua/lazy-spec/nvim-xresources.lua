return
{
	"martineausimon/nvim-xresources",
	lazy = false,
	priority = 1000,
	config = function()
		require("nvim-xresources").setup({
		})
		vim.cmd("colorscheme xresources")
	end,
}
