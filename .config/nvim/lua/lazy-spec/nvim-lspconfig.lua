return
{
	"neovim/nvim-lspconfig",
	dependencies = {
		-- {"williamboman/mason.nvim"},
		-- {"williamboman/mason-lspconfig.nvim"},
		{"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
	},
	config = function()
		local lsp_zero = require("lsp-zero")
		lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({buffer = bufnr})
				end)
		require("lspconfig").lua_ls.setup({})
	end,
}
