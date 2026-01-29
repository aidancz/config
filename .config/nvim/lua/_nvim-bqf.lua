vim.pack.add({
	"https://github.com/kevinhwang91/nvim-bqf",
})

require("bqf").setup({
	preview = {
		-- border = "bold",
		winblend = 0,
	},
})

vim.api.nvim_create_augroup("bqf_config", {clear = true})
vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "bqf_config",
		pattern = "qf",
		callback = function()
			vim.cmd("runtime after/ftplugin/qf/bqf.vim")
		end,
	}
)
