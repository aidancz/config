vim.pack.add({
	"https://github.com/stevearc/aerial.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("aerial").setup({
	keymaps = {
		["?"]     = false,
		["<C-j>"] = false,
		["<C-k>"] = false,
		["<C-s>"] = false,
		["<C-v>"] = false,
		["<a-j>"] = "actions.down_and_scroll",
		["<a-k>"] = "actions.up_and_scroll",
		["<a-s>"] = "actions.jump_split",
		["<a-v>"] = "actions.jump_vsplit",
	},
	layout = {
		width = nil,
		max_width = 0.3,
		min_width = nil,
		-- default_direction = "float",
		default_direction = "prefer_right",
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
