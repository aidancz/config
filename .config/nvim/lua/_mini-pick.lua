require("mini.deps").add({
	source = "echasnovski/mini.pick",
})

require("mini.pick").setup({
	mappings = {
	},
	options = {
		content_from_bottom = true,
	},
	window = {
		prompt_cursor = "█",
		prompt_prefix = "",
	},
})

require("nofrils").clear("^MiniPick")

-- vim.api.nvim_set_hl(0, "MiniPickBorderBusy",    {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent",  {link = "nofrils_reverse"})
vim.api.nvim_set_hl(0, "MiniPickMatchMarked",   {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "MiniPickMatchRanges",   {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "MiniPickPreviewLine",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "MiniPickPreviewRegion", {link = "nofrils_blue_bg"})
