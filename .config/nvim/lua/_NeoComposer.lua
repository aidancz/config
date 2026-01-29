vim.pack.add({
	"https://github.com/ecthelionvi/NeoComposer.nvim",
	"https://github.com/kkharji/sqlite.lua",
})

require("NeoComposer").setup({
	keymaps = {
		play_macro = "Q",
		yank_macro = "yq",
		stop_macro = "<nop>",
		toggle_record = "q",
		cycle_next = "<c-q>",
		cycle_prev = "<c-s-q>",
		toggle_macro_menu = "cq",
	},
})
