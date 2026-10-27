vim.pack.add({
	{
		src = "https://github.com/michaelb/sniprun",
		data = {
			on_packchanged = function(ev)
				local kind = ev.data.kind
				local kinds = {"install", "update"}
				if not vim.list_contains(kinds, kind) then return end
				local path = ev.data.path
				vim.system({"sh", "install.sh"}, {cwd = path}):wait()
			end,
		},
	},
})

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
