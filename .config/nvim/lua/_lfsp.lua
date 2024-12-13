vim.opt.runtimepath:prepend("~/sync_git/lfsp.nvim")

-- MiniDeps.add({
-- 	source = "aidancz/lfsp.nvim",
-- })

require("lfsp").setup({
	{
		type = "lf",
		follow = true,
		backward = "<up>",
		forward = "<down>",
	},
	{
		type = "sp",
		follow = true,
		backward = "<left>",
		forward = "<right>",
	},
})
