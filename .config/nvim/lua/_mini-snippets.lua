require("mini.deps").add({
	source = "echasnovski/mini.snippets",
})

require("mini.snippets").setup({
	snippets = {
		{
			prefix = "tis",
			body = "this is snippet",
			desc = "snip",
		},
		require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		require("mini.snippets").gen_loader.from_lang(),
	},
	mappings = {
		expand = "<c-d>",
		jump_next = "<c-f>",
		jump_prev = "<c-b>",
		stop = "<c-c>",
	},
})
