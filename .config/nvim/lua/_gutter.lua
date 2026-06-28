require("gutter").on()

require("luaexec").add({
	code = [[require("gutter").tog()]],
	from = "gutter",
})
