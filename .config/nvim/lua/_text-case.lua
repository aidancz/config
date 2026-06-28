vim.pack.add({
	"https://github.com/johmsalas/text-case.nvim",
})

require("textcase").setup({
	default_keymappings_enabled = true,
	prefix = "<space>u",
})
