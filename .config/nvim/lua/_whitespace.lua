vim.opt.runtimepath:prepend("~/sync_git/whitespace.nvim")

-- MiniDeps.add({
-- 	source = "aidancz/whitespace.nvim",
-- })

require("whitespace").setup({
	excluded_filetypes = {},
	excluded_buftypes = {".+"},
	init_switches = {
		false,
		false,
		false,
		true,
	},
})

vim.api.nvim_set_hl(0, "Whitespace1", {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "Whitespace2", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "Whitespace3", {link = "nofrils-yellow-bg"})
vim.api.nvim_set_hl(0, "Whitespace4", {link = "nofrils-red-bg"})

local toggle = function()
	vim.w.whitespace_switch_1 = not vim.w.whitespace_switch_1
	vim.w.whitespace_switch_2 = not vim.w.whitespace_switch_2
	vim.w.whitespace_switch_3 = not vim.w.whitespace_switch_3
	Whitespace.match_sync()
end
vim.keymap.set({"n", "x", "i"}, "<f11>", toggle)
