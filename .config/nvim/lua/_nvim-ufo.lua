require("mini.deps").add({
	source = "kevinhwang91/nvim-ufo",
	depends = {
		{
			source = "kevinhwang91/promise-async",
		},
	},
})

require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return ""
	end,
	fold_virt_text_handler = function() return vim.fn.getline(vim.v.foldstart) end,
})
