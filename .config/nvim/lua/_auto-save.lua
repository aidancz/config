require("mini.deps").add({
	source = "okuuva/auto-save.nvim",
})

require("auto-save").setup({
	lockmarks = true,
})

require("luaexec").add({
	code = [[require("auto-save").toggle()]],
	from = "auto-save",
})
