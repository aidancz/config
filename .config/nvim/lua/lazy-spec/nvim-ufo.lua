return
{
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return ""
			end,
			fold_virt_text_handler = function() return vim.fn.getline(vim.v.foldstart) end,
		})
	end,
}
