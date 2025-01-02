MiniDeps.add({
	source = "neovim/nvim-lspconfig",
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
