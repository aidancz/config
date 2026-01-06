require("macro").setup()

-- require("luaexec").add({
-- 	code =
-- [=[
-- if vim.fn.reg_recording() == "" then
-- 	return [[<cmd>lua require("macro").record_start()<cr>]]
-- else
-- 	return "q"
-- end
-- ]=],
-- 	from = "macro",
-- 	keys = {"n", "q"},
-- })

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
	keys = {"n", "Q"},
})

require("luaexec").add({
	code = [[require("macro").idx_next()]],
	from = "macro",
})

require("luaexec").add({
	code = [[require("macro").idx_prev()]],
	from = "macro",
})

require("luaexec").add({
	code =
[[
require("macro").idx_next()
require("macro").record_play()
require("macro").idx_prev()
]],
	from = "macro",
})

require("luaexec").add({
	code = [[require("macro").idx_reg()]],
	from = "macro",
})

require("luaexec").add({
	code = [[require("macro").record_edit()]],
	from = "macro",
	keys = {"n", "cq"},
})
