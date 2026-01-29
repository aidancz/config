vim.pack.add({
	"https://github.com/nvim-mini/mini.misc",
})

require("mini.misc").setup({
})

-- require("mini.misc").setup_auto_root()

require("mini.misc").setup_restore_cursor({
	center = false,
	-- ignore_filetype = {},
})

require("luaexec").add({
	code =
[[
require("mini.misc").zoom(
	nil,
	{
		height = vim.o.lines - 4,
		title = "",
	}
)
]],
	from = "mini.misc",
	name = "zoom",
	keys = {"n", "<cr>."},
})
