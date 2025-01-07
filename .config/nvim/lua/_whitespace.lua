vim.opt.runtimepath:prepend("~/sync_git/whitespace.nvim")

-- MiniDeps.add({
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
			id = "trail",
			pattern = [[\s\+$]],
			pattern_insert = [[\s\+\%#\@<!$]],
			default_display = true,
		},
		{
			id = "midmultispace",
			pattern = [=[]=],
			default_display = true,
		},
		{
			id = "midtab",
			pattern = [=[]=],
			default_display = true,
		},
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
	},
})

vim.api.nvim_set_hl(0, "trail",         {link = "nofrils-red-bg"})
vim.api.nvim_set_hl(0, "midmultispace", {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "midtab",        {link = "nofrils-yellow-bg"})
vim.api.nvim_set_hl(0, "space",         {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "tab",           {link = "nofrils-yellow-bg"})

local toggle = function()
	vim.w.space = not vim.w.space
	vim.w.tab = not vim.w.tab
	require("whitespace").match_sync()
end
vim.keymap.set({"n", "x", "i"}, "<f11>", toggle)
