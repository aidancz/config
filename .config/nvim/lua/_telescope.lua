MiniDeps.add({
	source = "nvim-telescope/telescope.nvim",
	depends = {
		{
			source = "nvim-lua/plenary.nvim",
		},
		{
			source = "nvim-telescope/telescope-fzf-native.nvim",
			hooks = {
				post_checkout = function(arg)
					vim.system({"make"}, {cwd = arg.path})
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
		layout_config = {
			horizontal = {
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
require("telescope").load_extension("ui-select")
