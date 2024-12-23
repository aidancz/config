MiniDeps.add({
	source = "ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	keymap = {
		builtin = {
		},
		fzf = {
			["f2"] = "abort",
			["f12"] = "abort",
		},
	},
	files = {
		cwd = require("fzf-lua/path").git_root(nil, true)
		-- https://github.com/ibhagwan/fzf-lua/issues/140
	}
})

pcall(require("nofrils").clear, {"^FzfLua"})

vim.keymap.set("n", "<f2>", require("fzf-lua").builtin)
