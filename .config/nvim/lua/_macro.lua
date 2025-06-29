require("macro").setup()

vim.keymap.set(
	"n",
	"q",
	function()
		if vim.fn.reg_recording() == "" then
			return [[<cmd>lua require("macro").record_start()<cr>]]
		else
			return "q"
		end
	end,
	{expr = true}
)

require("luaexec").add({
	code = [[require("macro").record_play()]],
	from = "macro",
	keys = {"n", "<tab>"},
})

require("luaexec").add({
	code = [[require("macro").idx_next()]],
	from = "macro",
	keys = {"n", "<c-tab>"},
})

require("luaexec").add({
	code = [[require("macro").idx_prev()]],
	from = "macro",
	keys = {"n", "<c-s-tab>"},
})

require("luaexec").add({
	code =
[[
require("macro").idx_next()
require("macro").record_play()
require("macro").idx_prev()
]],
	from = "macro",
	keys = {"n", "<s-tab>"},
})

require("luaexec").add({
	code = [[require("macro").idx_reg()]],
	from = "macro",
	keys = {"n", "<a-tab>"},
})

require("luaexec").add({
	code = [[require("macro").record_edit()]],
	from = "macro",
	keys = {"n", "cq"},
})
