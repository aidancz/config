vim.opt.runtimepath:prepend("~/sync_git/paramo.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/paramo.nvim",
-- })

require("paramo").setup({
	-- {
	-- 	type = "para0",
	-- 	type_config = {
	-- 		empty = true,
	-- 		include_more_indent = false,
	-- 		include_empty_lines = false,
	-- 	},
	-- 	backward = {
	-- 		head = "<a-b>",
	-- 		tail = "<a-g>",
	-- 		head_or_tail = "<a-p>",
	-- 	},
	-- 	forward = {
	-- 		head = "<a-w>",
	-- 		tail = "<a-e>",
	-- 		head_or_tail = "<a-n>",
	-- 	},
	-- },
	{
		type = "para1",
		type_config = {
			empty = false,
		},
		backward = {
			head = "<pageup>",
		},
		forward = {
			tail = "<pagedown>",
		},
	},
	{
		type = "para1",
		type_config = {
			empty = true,
		},
		backward = {
			head = "(",
			tail = "{",
		},
		forward = {
			head = "}",
			tail = ")",
		},
	},
	{
		type = "para2",
		type_config = {
			empty = false,
		},
		backward = {
			head = "<c-s-b>",
			tail = "<c-s-g>",
		},
		forward = {
			head = "<c-s-w>",
			tail = "<c-s-e>",
		},
	},
})
