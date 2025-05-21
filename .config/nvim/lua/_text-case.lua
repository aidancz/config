require("mini.deps").add({
	source = "johmsalas/text-case.nvim",
})

require("textcase").setup({
})

require("luaexec").add({
	code = [[require("textcase").operator("to_upper_case")]],
	from = "text-case",
	name = [["LOREM IPSUM"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_lower_case")]],
	from = "text-case",
	name = [["lorem ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_snake_case")]],
	from = "text-case",
	name = [["lorem_ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_dash_case")]],
	from = "text-case",
	name = [["lorem-ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_title_dash_case")]],
	from = "text-case",
	name = [["Lorem-Ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_constant_case")]],
	from = "text-case",
	name = [["LOREM_IPSUM"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_dot_case")]],
	from = "text-case",
	name = [["lorem.ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_comma_case")]],
	from = "text-case",
	name = [["lorem,ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_camel_case")]],
	from = "text-case",
	name = [["loremIpsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_pascal_case")]],
	from = "text-case",
	name = [["LoremIpsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_title_case")]],
	from = "text-case",
	name = [["Lorem Ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_path_case")]],
	from = "text-case",
	name = [["lorem/ipsum"]],
})

require("luaexec").add({
	code = [[require("textcase").operator("to_phrase_case")]],
	from = "text-case",
	name = [["Lorem ipsum"]],
})
