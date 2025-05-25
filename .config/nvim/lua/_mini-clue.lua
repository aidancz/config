require("mini.deps").add({
	source = "echasnovski/mini.clue",
})

require("mini.clue").setup({
	triggers = {
		{mode = "c", keys = "<c-r>"},
		{mode = "i", keys = "<c-r>"},
		{mode = "i", keys = "<c-x>"},
		{mode = "n", keys = "<c-w>"},
		{mode = "n", keys = "<leader>"},
		{mode = "n", keys = "g"},
		{mode = "n", keys = "z"},
		{mode = "n", keys = [["]]},
		{mode = "n", keys = [[']]},
		{mode = "n", keys = [[`]]},
		{mode = "x", keys = "<leader>"},
		{mode = "x", keys = "g"},
		{mode = "x", keys = "z"},
		{mode = "x", keys = [["]]},
		{mode = "x", keys = [[']]},
		{mode = "x", keys = [[`]]},
	},
	clues = {
		require("mini.clue").gen_clues.builtin_completion(),
		require("mini.clue").gen_clues.g(),
		require("mini.clue").gen_clues.marks(),
		require("mini.clue").gen_clues.registers(),
		require("mini.clue").gen_clues.windows({
			submode_move = true,
			submode_navigate = true,
			submode_resize = true,
		}),
		require("mini.clue").gen_clues.z(),
	},
	window = {
		config = {
			width = math.floor(vim.o.columns / 4),
			-- border = "none",
			-- anchor = "NE",
			-- row = "auto",
			-- col = "auto",
		},
		delay = 0,
	},
})
