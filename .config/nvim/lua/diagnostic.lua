vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	signs = true,
	float = {
		border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
	},
})

vim.api.nvim_set_hl(0, "DiagnosticError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticInfo",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticHint",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticSignError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticSignHint",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticSignOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticDeprecated",  {link = "nofrils-magenta"})
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {link = "nofrils-magenta"})
