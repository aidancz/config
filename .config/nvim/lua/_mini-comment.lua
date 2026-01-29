vim.pack.add({
	"https://github.com/nvim-mini/mini.comment",
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return
			require("ts_context_commentstring").calculate_commentstring()
		end,
	},
	mappings = {
		comment = "",
		comment_line = "",
		comment_visual = "",
		textobject = "ic",
	},
})
