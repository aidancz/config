require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	keymap = {
		builtin = {
		},
		fzf = {
			["ctrl-a"] = "first",
			["ctrl-e"] = "last",
		},
	},
	-- files = {
	-- 	cwd = require("fzf-lua/path").git_root(nil, true)
	-- 	-- https://github.com/ibhagwan/fzf-lua/issues/140
	-- },
	winopts = {
		border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
		backdrop = 100,
		preview = {
			border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
		},
	},
})

pcall(function()
require("nofrils").clear({"^FzfLua"})
end)

vim.keymap.set("n", "ff", require("fzf-lua").builtin)
