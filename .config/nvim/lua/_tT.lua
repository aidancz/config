vim.opt.runtimepath:prepend("~/sync_git/tT.nvim")

-- MiniDeps.add({
-- 	source = "aidancz/tT.nvim",
-- })

require("tT").setup({
	t = "t",
	T = "T",
})
