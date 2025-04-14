require("mini.deps").add({
	source = "nvim-telescope/telescope.nvim",
	depends = {
		{
			source = "nvim-lua/plenary.nvim",
		},
		{
			source = "nvim-telescope/telescope-fzf-native.nvim",
			hooks = {
				post_install = function(arg)
					vim.system({"make"}, {cwd = arg.path}):wait()
				end,
				post_checkout = function(arg)
					vim.system({"make"}, {cwd = arg.path}):wait()
				end,
			},
		},
		{
			source = "nvim-telescope/telescope-ui-select.nvim",
		},
	},
})

require("telescope").setup({
	defaults = {
		borderchars = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_cutoff = 0,
				preview_width = 0.5
			},
		},
		mappings = {
			i = {
				["<esc>"] = "close",
				["<c-u>"] = false,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

require("telescope").load_extension("fzf")

-- require("telescope").load_extension("ui-select")
