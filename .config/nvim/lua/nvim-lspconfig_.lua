vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
})
