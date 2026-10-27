vim.pack.add({
	"https://github.com/kevinhwang91/nvim-ufo",
	"https://github.com/kevinhwang91/promise-async",
})

require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return ""
	end,
	fold_virt_text_handler = function() return vim.fn.getline(vim.v.foldstart) end,
})
