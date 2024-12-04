vim.opt.runtimepath:prepend("~/sync_git/whitespace.nvim")

-- MiniDeps.add({
-- 	source = "aidancz/whitespace.nvim",
-- })

require("whitespace").setup({
	only_in_normal_buffers = true,
	set_init_switches = function()
		vim.b.whitespace_switch_1 = false
		vim.b.whitespace_switch_2 = false
		vim.b.whitespace_switch_3 = false
		vim.b.whitespace_switch_4 = true
	end,
})

vim.api.nvim_set_hl(0, "Whitespace1", {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "Whitespace2", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "Whitespace3", {link = "nofrils-yellow-bg"})
vim.api.nvim_set_hl(0, "Whitespace4", {link = "nofrils-red-bg"})

local toggle = function()
	vim.b.whitespace_switch_1 = not vim.b.whitespace_switch_1
	vim.b.whitespace_switch_2 = not vim.b.whitespace_switch_2
	vim.b.whitespace_switch_3 = not vim.b.whitespace_switch_3
	require("whitespace").match_sync()
end
vim.keymap.set({"n", "x", "i"}, "<f11>", toggle)
