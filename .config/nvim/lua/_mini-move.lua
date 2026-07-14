vim.pack.add({
	"https://github.com/nvim-mini/mini.move",
})

require("mini.move").setup({
	mappings = {
		left       = "",
		right      = "",
		down       = "",
		up         = "",
		line_left  = "",
		line_right = "",
		line_down  = "",
		line_up    = "",
	},
	options = {
		reindent_linewise = false,
	},
})

require("luaexec").add({
	code = [[require("mini.move").move_line("left")]],
	from = "mini.move",
	keys = {"n", "<c-s>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_line("right")]],
	from = "mini.move",
	keys = {"n", "<c-g>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_line("down")]],
	from = "mini.move",
	keys = {"n", "<c-f>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_line("up")]],
	from = "mini.move",
	keys = {"n", "<c-d>"},
})

require("luaexec").add({
	code = [[require("mini.move").move_selection("left")]],
	from = "mini.move",
	keys = {"x", "<c-s>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_selection("right")]],
	from = "mini.move",
	keys = {"x", "<c-g>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_selection("down")]],
	from = "mini.move",
	keys = {"x", "<c-f>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_selection("up")]],
	from = "mini.move",
	keys = {"x", "<c-d>"},
})
