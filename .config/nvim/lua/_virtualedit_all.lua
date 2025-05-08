require("virtualedit_all").setup()

require("luaexec").add_mode({
	name = "virtualedit_all",
	chunks = {
		{
			code = [[require("virtualedit_all").tog()]],
		},
		{
			code = [[require("virtualedit_all").fix_insertleave_cursor_tog()]],
		},
		{
			code = [[require("virtualedit_all").fix_modechanged_tog()]],
		},
		{
			code = [[require("virtualedit_all").fix_modechanged_cursor_restore()]],
			gkey = {"n", "fo"},
		},
		{
			code = [[require("virtualedit_all").fix_paste_tog()]],
		},
	},
})
