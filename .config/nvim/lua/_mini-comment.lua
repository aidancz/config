vim.pack.add({
	"https://github.com/nvim-mini/mini.comment",
	"https://github.com/folke/ts-comments.nvim",
})

require("ts-comments").setup({
	lang = {
		bash = "# %s",
		lua = "-- %s",
		scheme = { ";; %s", "; %s" },
	},
})

require("mini.comment").setup({
	options = {
		-- custom_commentstring = function(ref_position)
		-- end,
	},
	mappings = {
		comment = "<space>c",
		comment_line = "",
		comment_visual = "<space>c",
		textobject = "ac",
	},
})
