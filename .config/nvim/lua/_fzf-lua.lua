-- https://github.com/ibhagwan/fzf-lua/issues/140

require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	winopts = {
		border = "bold",
		backdrop = 100,
		preview = {
			border = "bold",
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

require("nofrils").clear("^FzfLua")

vim.keymap.set("n", "f/", require("fzf-lua").builtin)
vim.keymap.set("n", "f.", require("fzf-lua").resume)
vim.keymap.set("n", "ff", require("fzf-lua").files)
vim.keymap.set("n", "fn", require("fzf-lua").buffers)
vim.keymap.set("n", "fh", require("fzf-lua").helptags)
