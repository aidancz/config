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
			local commentstring

			commentstring = vim.bo.commentstring
			if commentstring ~= "" then return commentstring end

			commentstring = require("ts_context_commentstring").calculate_commentstring()
			if commentstring ~= nil then return commentstring end

			commentstring = "# %s"
			return commentstring
		end,
	},
	mappings = {
		comment = "<space>c",
		comment_line = "",
		comment_visual = "<space>c",
		textobject = "ac",
	},
})
