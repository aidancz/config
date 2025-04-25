require("mini.deps").add({
	source = "echasnovski/mini.misc",
})

require("mini.misc").setup({
})

-- require("mini.misc").setup_auto_root()

require("modexec").add_mode({
	name = "mini.misc",
	chunks = {
		{
			code = [[require("mini.misc").zoom()]],
			name = "zoom",
		},
	},
})
