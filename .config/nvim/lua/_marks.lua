require("mini.deps").add({
	source = "chentoast/marks.nvim",
})

require("marks").setup({
	default_mappings = false,
	builtin_marks = {},
	cyclic = true,
	force_write_shada = false,
	refresh_interval = 150,
	sign_priority = {lower=11, upper=12, builtin=14, bookmark=13},
	excluded_filetypes = {},
	excluded_buftypes = {"nofile", "terminal"},
	bookmark_0 = {
		sign = "⚑",
		virt_text = "",
		annotate = false,
	},
	mappings = {}
})

require("nofrils").clear("^Mark")
