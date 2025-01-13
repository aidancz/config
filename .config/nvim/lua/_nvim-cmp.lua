require("mini.deps").add({
	source = "hrsh7th/nvim-cmp",
	depends = {
		{
			source = "hrsh7th/cmp-path",
		},
		{
			source = "hrsh7th/cmp-buffer",
		},
		{
			source = "hrsh7th/cmp-cmdline",
		},
		{
			source = "hrsh7th/cmp-nvim-lsp",
		},
	},
})



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
