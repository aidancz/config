return
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		{"hrsh7th/cmp-path"},
		{"hrsh7th/cmp-buffer"},
		{"hrsh7th/cmp-cmdline"},
		{"hrsh7th/cmp-nvim-lsp"},
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			window = {
				completion    = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{
					{name = "path"},
				},
				{
					{name = "cmdline"},
				}),
		})
		-- cmp.setup.cmdline({"/", "?"}, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = {
		-- 		{name = "buffer"},
		-- 	}
		-- })
	end,
}
