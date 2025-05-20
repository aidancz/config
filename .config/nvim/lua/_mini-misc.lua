require("mini.deps").add({
	source = "echasnovski/mini.misc",
})

require("mini.misc").setup({
})

-- require("mini.misc").setup_auto_root()

require("luaexec").add({
	code = [[require("mini.misc").zoom()]],
	from = "mini.misc",
	name = "zoom",
})
