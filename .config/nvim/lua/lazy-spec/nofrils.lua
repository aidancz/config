return
{
	"aidancz/nofrils",
	dev = true,
	lazy = false,
	priority = 1000,
	-- https://lazy.folke.io/spec/lazy_loading#-colorschemes
	config = function()
		vim.cmd("colorscheme nofrils")
	end,
}
