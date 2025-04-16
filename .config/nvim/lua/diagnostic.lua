vim.diagnostic.config({
	underline = true,
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
		source = true,
		spacing = 0,
		virt_text_pos = "eol_right_align",
	},
	virtual_lines = false,
	signs = {
		priority = 10,
	},
})

vim.api.nvim_set_hl(0, "DiagnosticError", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiagnosticWarn",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticInfo",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticHint",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticOk",    {link = "nofrils_green"})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk",    {link = "nofrils_green"})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk",    {link = "nofrils_green"})

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticFloatingOk",    {link = "nofrils_green"})

vim.api.nvim_set_hl(0, "DiagnosticSignError", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignHint",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticSignOk",    {link = "nofrils_green"})

vim.api.nvim_set_hl(0, "DiagnosticDeprecated",  {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {link = "nofrils_yellow"})
