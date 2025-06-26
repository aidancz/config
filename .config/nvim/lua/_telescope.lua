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

-- HACK: https://github.com/nvim-telescope/telescope.nvim/issues/3436
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopeFindPre",
	callback = function()
		vim.opt_local.winborder = "none"
		vim.api.nvim_create_autocmd("WinLeave", {
			once = true,
			callback = function()
				vim.opt_local.winborder = "bold"
			end,
		})
	end,
})

require("telescope").setup({
	defaults = {
		border = true,
		borderchars = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				height = vim.o.lines,
				width = vim.o.columns,
				prompt_position = "top",
				preview_cutoff = 0,
				preview_width = 0.5
			},
		},
		mappings = {
			i = {
				["<f1>"] = "close",
				-- ["<esc>"] = "close",
				["<c-u>"] = false,
				["<pageup>"] = "preview_scrolling_up",
				["<pagedown>"] = "preview_scrolling_down",
			},
			n = {
				["<f1>"] = "close",
				["<esc>"] = false,
			},
		},
		sorting_strategy = "ascending",
		wrap_results = false,
	},
	extensions = {
		-- ["ui-select"] = {
		-- 	require("telescope.themes").get_dropdown(),
		-- },
	},
})

vim.api.nvim_set_hl(0, "TelescopeMatching",  {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "TelescopeSelection", {link = "nofrils_reverse"})

require("telescope").load_extension("fzf")
-- require("telescope").load_extension("ui-select")
