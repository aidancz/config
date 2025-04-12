-- require("mini.deps").add({
-- 	source = "aidancz/whitespace.nvim",
-- })

require("whitespace").setup({
	excluded_filetypes = {
	},
	excluded_buftypes = {
		".+",
	},
	definition = {
		{
			id = "space",
			pattern = [[ ]],
			default_display = false,
		},
		{
			id = "tab",
			pattern = [[\t]],
			default_display = false,
		},
		{
			id = "multispace",
			pattern = [[ \{2,}]],
			default_display = false,
		},
		{
			id = "trail",
			pattern = [[\s\+$]],
			pattern_insert = [[\s\+\%#\@<!$]],
			default_display = true,
		},
	},
})

vim.api.nvim_set_hl(0, "space",      {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "tab",        {link = "nofrils_yellow_bg"})
vim.api.nvim_set_hl(0, "multispace", {link = "nofrils_magenta_bg"})
vim.api.nvim_set_hl(0, "trail",      {link = "nofrils_red_bg"})

vim.keymap.set({"n", "x", "i"}, "<a-v>", function()
	vim.w.space      = not vim.w.space
	vim.w.tab        = not vim.w.tab
	vim.w.multispace = not vim.w.multispace
	require("whitespace").match_sync()
	end)
