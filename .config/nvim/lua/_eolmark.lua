vim.opt.runtimepath:prepend("~/sync_git/eolmark.nvim")

-- MiniDeps.add({
-- 	source = "aidancz/eolmark.nvim",
-- })

require("eolmark").setup({
	mark = "○",
	excluded_filetypes = {
	},
	excluded_buftypes = {
		"nofile",
		"terminal",
	},
})

vim.api.nvim_set_hl(0, "EolMark", {link = "NonText"})
