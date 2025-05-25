require("virtualedit_all").setup()

require("luaexec").add({
	code = [[require("virtualedit_all").tog()]],
	from = "virtualedit_all",
})

require("luaexec").add({
	code = [[require("virtualedit_all").insertleave_cursor_tog()]],
	from = "virtualedit_all",
})

require("luaexec").add({
	code = [[require("virtualedit_all").modechanged_tog()]],
	from = "virtualedit_all",
})

require("luaexec").add({
	code = [[require("virtualedit_all").modechanged_cursor_restore()]],
	from = "virtualedit_all",
	keys = {"n", "go"},
})

require("luaexec").add({
	code = [[require("virtualedit_all").paste_tog()]],
	from = "virtualedit_all",
})
