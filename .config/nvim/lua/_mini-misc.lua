require("mini.deps").add({
	source = "echasnovski/mini.misc",
})

require("mini.misc").setup({
})

-- require("mini.misc").setup_auto_root()

require("luaexec").add({
	code =
[[
require("mini.misc").zoom(
	nil,
	{
		height = vim.o.lines - 4,
	}
)
]],
	from = "mini.misc",
	name = "zoom",
	keys = {"n", "rr"},
})
