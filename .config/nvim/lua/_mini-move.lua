require("mini.deps").add({
	source = "echasnovski/mini.move",
})

require("mini.move").setup({
	mappings = {
		left       = "<c-h>",
		right      = "<c-l>",
		down       = "<c-j>",
		up         = "<c-k>",
		line_left  = "<c-h>",
		line_right = "<c-l>",
		line_down  = "<c-j>",
		line_up    = "<c-k>",
	},
	options = {
		reindent_linewise = false,
	},
})
