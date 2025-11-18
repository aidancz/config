require("mini.deps").add({
	source = "nvim-mini/mini.align",
})

require("mini.align").setup({
	-- silent = true,
	mappings = {
		start = "ga",
		start_with_preview = "gz",
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
