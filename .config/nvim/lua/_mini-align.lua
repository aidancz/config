require("mini.deps").add({
	source = "nvim-mini/mini.align",
})

require("mini.align").setup({
	-- silent = true,
	mappings = {
		start = "gl",
		start_with_preview = "gL",
	},
	modifiers = {
		q = function(steps, _)
			table.insert(
				steps.pre_split,
				require("mini.align").gen_step.ignore_split(
					{
						[[".-"]],
						[['.-']],
					},
					true
				)
			)
		end,
	},
})

vim.keymap.set("n", "gll", "gl_", {remap = true})
