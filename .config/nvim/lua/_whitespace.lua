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
	init_switches = {
		whitespace_switch_1 = false,
		whitespace_switch_2 = false,
		whitespace_switch_3 = false,
		whitespace_switch_4 = false,
		whitespace_switch_5 = false,
		whitespace_switch_6 = false,
		whitespace_switch_7 = false,
		whitespace_switch_8 = false,
		whitespace_switch_9 = true,
	},
})

vim.api.nvim_set_hl(0, "Whitespace1", {link = "nofrils-blue-bg"})
vim.api.nvim_set_hl(0, "Whitespace2", {link = "nofrils-yellow-bg"})
vim.api.nvim_set_hl(0, "Whitespace3", {link = "nofrils-green-bg"})
vim.api.nvim_set_hl(0, "Whitespace4", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "Whitespace5", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "Whitespace6", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "Whitespace7", {link = "nofrils-magenta-bg"})
vim.api.nvim_set_hl(0, "Whitespace8", {link = "nofrils-cyan-bg"})
vim.api.nvim_set_hl(0, "Whitespace9", {link = "nofrils-red-bg"})

local toggle = function()
	vim.w.whitespace_switch_1 = not vim.w.whitespace_switch_1
	vim.w.whitespace_switch_2 = not vim.w.whitespace_switch_2
	-- vim.w.whitespace_switch_3 = not vim.w.whitespace_switch_3
	vim.w.whitespace_switch_4 = not vim.w.whitespace_switch_4
	-- vim.w.whitespace_switch_5 = not vim.w.whitespace_switch_5
	-- vim.w.whitespace_switch_6 = not vim.w.whitespace_switch_6
	-- vim.w.whitespace_switch_7 = not vim.w.whitespace_switch_7
	-- vim.w.whitespace_switch_8 = not vim.w.whitespace_switch_8
	-- vim.w.whitespace_switch_9 = not vim.w.whitespace_switch_9
	require("whitespace").match_sync()
end
vim.keymap.set({"n", "x", "i"}, "<f11>", toggle)
