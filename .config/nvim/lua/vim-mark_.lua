vim.pack.add({
	"https://github.com/inkarkat/vim-mark",
	"https://github.com/inkarkat/vim-ingo-library",
})

vim.api.nvim_set_hl(0, "MarkWord1", {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "MarkWord2", {link = "nofrils_green_bg"})
vim.api.nvim_set_hl(0, "MarkWord3", {link = "nofrils_cyan_bg"})
vim.api.nvim_set_hl(0, "MarkWord4", {link = "nofrils_red_bg"})
vim.api.nvim_set_hl(0, "MarkWord5", {link = "nofrils_magenta_bg"})
vim.api.nvim_set_hl(0, "MarkWord6", {link = "nofrils_yellow_bg"})
