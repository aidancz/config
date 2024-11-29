MiniDeps.add({
	source = "neovim/nvim-lspconfig",
	depends = {
		{
			source = "VonHeikemen/lsp-zero.nvim",
		},
	},
})

local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
		lsp_zero.default_keymaps({buffer = bufnr})
		end)
require("lspconfig").lua_ls.setup({})
