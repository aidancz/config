MiniDeps.add({
	source = "stevearc/aerial.nvim",
	depends = {
		{
			source = "nvim-treesitter/nvim-treesitter",
		},
	},
})

require("aerial").setup({
	keymaps = {
		["?"]      = false,
		["<C-j>"]  = false,
		["<C-k>"]  = false,
		["<C-s>"]  = false,
		["<C-v>"]  = false,
		["<a-j>"]  = "actions.down_and_scroll",
		["<a-k>"]  = "actions.up_and_scroll",
		["<a-s>"]  = "actions.jump_split",
		["<a-v>"]  = "actions.jump_vsplit",
	},
	layout = {
		width = 0.5,
		max_width = 0.5,
		min_width = 0.5,
		default_direction = "float",
		resize_to_content = false,
	},
	float = {
		height = 0.8,
		max_height = 0.8,
		min_height = 0.8,
		border = "single",
		relative = "editor",
	},
	icons = {
		Collapsed = "●",
	},
})
vim.keymap.set("n", "<f3>", "<cmd>AerialToggle<cr>")
