vim.pack.add({
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("Comment").setup({
	toggler = {
		line = "<space>c.",
		block = "<space>b.",
	},
	opleader = {
		line = "<space>c",
		block = "<space>b",
	},
	extra = {
		above = "<nop>",
		below = "<nop>",
		eol = "<nop>",
	},
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
