vim.api.nvim_create_autocmd(
	{
		"BufEnter",
	},
	{
		callback = function()
			vim.print(os.time())
		end,
	}
)
