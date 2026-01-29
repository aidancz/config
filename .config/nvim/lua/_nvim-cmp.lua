vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
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
