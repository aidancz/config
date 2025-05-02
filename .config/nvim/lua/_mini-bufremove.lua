require("mini.deps").add({
	source = "echasnovski/mini.bufremove",
})

require("mini.bufremove").setup({
})

require("modexec").add_mode({
	name = "mini.bufremove",
	chunks = {
		{
			code = [[require("mini.bufremove").delete()]],
		},
	},
})
