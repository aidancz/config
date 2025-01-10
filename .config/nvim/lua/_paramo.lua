vim.opt.runtimepath:prepend("~/sync_git/paramo.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/paramo.nvim",
-- })

require("paramo").setup({
	-- {
	-- 	type = "para0",
	-- 	backward = "{",
	-- 	forward = "}",
	-- },
	{
		type = "para1",
		screen_or_logical_column = "screen",
		backward = "(",
		forward = ")",
	},
	{
		type = "para2",
		screen_or_logical_column = "screen",
		backward = "<home>",
		forward = "<end>",
	},
})
