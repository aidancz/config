return
{
	"utilyre/sentiment.nvim",
	init = function()
		vim.g.loaded_matchparen = 1
		vim.opt.showmatch = false
	end,
	config = function()
		require("sentiment").setup({
			included_modes = {
				n = true,
				i = true,
			},
			delay = 0,
		})
	end,
}
