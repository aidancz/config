require("mini.deps").add({
	source = "echasnovski/mini.move",
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
	keys = {{"n", "i"}, "<c-h>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_line("right")]],
	from = "mini.move",
	keys = {{"n", "i"}, "<c-l>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_line("down")]],
	from = "mini.move",
	keys = {{"n", "i"}, "<c-j>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_line("up")]],
	from = "mini.move",
	keys = {{"n", "i"}, "<c-k>"},
})

require("luaexec").add({
	code = [[require("mini.move").move_selection("left")]],
	from = "mini.move",
	keys = {"x", "<c-h>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_selection("right")]],
	from = "mini.move",
	keys = {"x", "<c-l>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_selection("down")]],
	from = "mini.move",
	keys = {"x", "<c-j>"},
})
require("luaexec").add({
	code = [[require("mini.move").move_selection("up")]],
	from = "mini.move",
	keys = {"x", "<c-k>"},
})
