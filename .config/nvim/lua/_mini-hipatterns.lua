require("mini.deps").add({
	source = "echasnovski/mini.hipatterns",
})

require("mini.hipatterns").setup({
	highlighters = {
		fixme = {
			pattern = "%f[%w]()FIXME()%f[%W]",
			group = "nofrils_magenta_bg",
		},
		hack = {
			pattern = "%f[%w]()HACK()%f[%W]",
			group = "nofrils_magenta_bg",
		},
		todo = {
			pattern = "%f[%w]()TODO()%f[%W]",
			group = "nofrils_magenta_bg",
		},
		note = {
			pattern = "%f[%w]()NOTE()%f[%W]",
			group = "nofrils_magenta_bg",
		},
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color({
			style = "full",
		}),
	},
})
