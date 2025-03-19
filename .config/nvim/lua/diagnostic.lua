vim.diagnostic.config({
	underline = true,
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
		source = true,
		spacing = 0,
		virt_text_pos = "right_align",
	},
	signs = true,
	float = {
		border = vim.co.border,
	},
})

vim.api.nvim_set_hl(0, "DiagnosticError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticInfo",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticHint",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticSignError", {link = "nofrils-red"})
vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignHint",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignOk",    {link = "nofrils-green"})

vim.api.nvim_set_hl(0, "DiagnosticDeprecated",  {link = "nofrils-yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {link = "nofrils-yellow"})
