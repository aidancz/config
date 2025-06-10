require("mini.deps").add({
	source = "nvim-treesitter/nvim-treesitter-textobjects",
})

require("nvim-treesitter.configs").setup({
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- custom capture:
				["ic"] = "@code_block.inner",
				["ac"] = "@code_block.outer",
				["iF"] = "@call.name",
				["aF"] = "@call.name",
				-- builtin capture:
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["if"] = "@call.inner",
				["af"] = "@call.outer",
			},
			selection_modes = {
				["@code_block.inner"] = "V",
				["@code_block.outer"] = "V",
			},
		},
	},
})
