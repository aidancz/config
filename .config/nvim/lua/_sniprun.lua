MiniDeps.add({
	source = "michaelb/sniprun",
	hooks = {
		post_checkout = function(arg)
			vim.system({"sh", "install.sh"}, {cwd = arg.path})
		end,
	},
})

-- `arg` is a table:
-- {
--   name = "sniprun",
--   path = "/home/aidan/.local/share/nvim/site/pack/deps/opt/sniprun",
--   source = "https://github.com/michaelb/sniprun"
-- }

require("sniprun").setup({
	selected_interpreters = {
		"Lua_nvim",
	},
	repl_enable = {
	},
	interpreter_options = {
	},
	display = {
		"Classic",
	},
})
