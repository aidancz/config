require("virtualedit_all").setup()

require("luaexec").add({
	code = [[require("virtualedit_all").tog()]],
	from = "virtualedit_all",
})

require("luaexec").add({
	code = [[require("virtualedit_all").fix_insertleave_cursor_tog()]],
	from = "virtualedit_all",
})

require("luaexec").add({
	code = [[require("virtualedit_all").fix_modechanged_tog()]],
	from = "virtualedit_all",
})

require("luaexec").add({
	code = [[require("virtualedit_all").fix_modechanged_cursor_restore()]],
	from = "virtualedit_all",
	gkey = {"n", "fo"},
})

require("luaexec").add({
	code = [[require("virtualedit_all").fix_paste_tog()]],
	from = "virtualedit_all",
})
