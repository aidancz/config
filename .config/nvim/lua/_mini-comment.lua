require("mini.deps").add({
	source = "echasnovski/mini.comment",
	depends = {
		{
			source = "JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
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
		textobject = "gc",
	},
})
