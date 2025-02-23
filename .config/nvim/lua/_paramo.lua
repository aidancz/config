vim.opt.runtimepath:prepend("~/sync_git/paramo.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/paramo.nvim",
-- })

require("paramo").setup({
	{
		type = "para3",
		type_config = {
			-- empty = false,
			indent = "eq",
			include_more_indent = true,
			include_empty = true,
		},
		backward = {
			head = "<a-b>",
			tail = "<a-g>",
			head_or_tail = "<pageup>",
		},
		forward = {
			head = "<a-w>",
			tail = "<a-e>",
			head_or_tail = "<pagedown>",
		},
	},
})
