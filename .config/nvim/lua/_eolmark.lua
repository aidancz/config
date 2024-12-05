vim.opt.runtimepath:prepend("~/sync_git/eolmark.nvim")

-- MiniDeps.add({
-- 	source = "aidancz/eolmark.nvim",
-- })

require("eolmark").setup({
	excluded_filetypes = {
	},
	excluded_buftypes = {
	},
	opts = {
		virt_text = {{"○", "NonText"}},
	},
})
