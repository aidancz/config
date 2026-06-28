vim.pack.add({
	"https://github.com/AckslD/nvim-neoclip.lua",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/kkharji/sqlite.lua",
})

require("neoclip").setup({
	default_register = {[["]], [[*]], [[+]]},
	enable_persistent_history = true,
})

require("luaexec").add({
	code = [[require("neoclip.fzf")()]],
	from = "neoclip",
	keys = {"n", "<cr>y"},
})
