vim.opt.runtimepath:prepend("~/sync_git/tT.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/tT.nvim",
-- })

require("tT").setup({
	t = "t",
	T = "T",
})
