return
{
	"michaelb/sniprun",
	build = "sh install.sh",
	config = function()
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
	end,
}
