return
{
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("undotree").setup({
			window = {
				winblend = 0,
			},
		})
		vim.keymap.set("n", "<f7>", require('undotree').toggle)
		vim.api.nvim_set_hl(0, "UndotreeDiffAdded",   {link = "nofrils-green"})
		vim.api.nvim_set_hl(0, "UndotreeDiffRemoved", {link = "nofrils-red"})
		vim.api.nvim_set_hl(0, "UndotreeDiffLine",    {link = "nofrils-blue"})
	end,
}
