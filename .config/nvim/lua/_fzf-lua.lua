-- https://github.com/ibhagwan/fzf-lua/issues/140

require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	winopts = {
		backdrop = 100,
		preview = {
			winopts = {
				number = false,
			},
		},
	},
	keymap = {
		builtin = {
			true,
		},
		fzf = {
			true,
			["ctrl-a"] = "first",
			["ctrl-e"] = "last",
		},
	},
})

require("nofrils").clear({"^FzfLua"})

vim.keymap.set("n", "ff", require("fzf-lua").builtin)
