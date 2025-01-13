vim.opt.runtimepath:prepend("~/sync_git/whitespace.nvim")

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
		-- {
		-- 	id = "multispace",
		-- 	pattern = [[ \{2,}]],
		-- 	default_display = true,
		-- },
		-- {
		-- 	id = "tab",
		-- 	pattern = [[\t]],
		-- 	default_display = true,
		-- },
		-- {
		-- 	id = "lead",
		-- 	pattern = [[^\s\+]],
		-- 	default_display = true,
		-- },
		{
			id = "trail",
			pattern = [[\s\+$]],
			pattern_insert = [[\s\+\%#\@<!$]],
			default_display = true,
		},
		{
			id = "space_override",
			pattern = [[ ]],
			default_display = false,
		},
		{
			id = "tab_override",
			pattern = [[\t]],
			default_display = false,
		},
	},
})

-- vim.api.nvim_set_hl(0, "multispace",     {link = "nofrils-blue-bg"})
-- vim.api.nvim_set_hl(0, "tab",            {link = "nofrils-yellow-bg"})
-- vim.api.nvim_set_hl(0, "lead",           {link = "nofrils-black-bg"})
vim.api.nvim_set_hl(0, "trail",          {link = "nofrils-red-bg"})
vim.api.nvim_set_hl(0, "space_override", {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "tab_override",   {link = "nofrils-yellow-bg"})

vim.keymap.set({"n", "x", "i"}, "<f11>", function()
	vim.w.space_override = not vim.w.space_override
	vim.w.tab_override   = not vim.w.tab_override
	require("whitespace").match_sync()
	end)
