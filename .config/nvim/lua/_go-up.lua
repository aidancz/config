-- require("mini.deps").add({
-- 	source = "aidancz/go-up.nvim",
-- })

require("go-up").setup({
})

-- # virtual lines

require("luaexec").add({
	code = [[require("go-up").toggle_autocmd()]],
	from = "go-up",
})

-- # scroll

require("luaexec").add({
	code = [[require("go-up").scroll(0 + vim.api.nvim_win_get_height(0) * (1 / 4))]],
	from = "go-up",
	name = "scroll +1/4",
	keys = {{"n", "x"}, "<c-f>"},
})
require("luaexec").add({
	code = [[require("go-up").scroll(0 - vim.api.nvim_win_get_height(0) * (1 / 4))]],
	from = "go-up",
	name = "scroll -1/4",
	keys = {{"n", "x"}, "<c-d>"},
})
require("luaexec").add({
	code = [[require("go-up").scroll(0 + vim.api.nvim_win_get_height(0) * (2 / 4))]],
	from = "go-up",
	name = "scroll +2/4",
	keys = {{"n", "x"}, "<c-g>"},
})
require("luaexec").add({
	code = [[require("go-up").scroll(0 - vim.api.nvim_win_get_height(0) * (2 / 4))]],
	from = "go-up",
	name = "scroll -2/4",
	keys = {{"n", "x"}, "<c-s>"},
})
require("luaexec").add({
	code = [[require("go-up").scroll(0 + vim.api.nvim_win_get_height(0) * (4 / 4))]],
	from = "go-up",
	name = "scroll +4/4",
	keys = {{"n", "x"}, "f"},
})
require("luaexec").add({
	code = [[require("go-up").scroll(0 - vim.api.nvim_win_get_height(0) * (4 / 4))]],
	from = "go-up",
	name = "scroll -4/4",
	keys = {{"n", "x"}, "d"},
})

-- # recenter

require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (0 / 4))]],
	from = "go-up",
	name = "recenter 0/4",
	keys = {{"n", "x"}, "<space>s"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (1 / 4))]],
	from = "go-up",
	name = "recenter 1/4",
	keys = {{"n", "x"}, "<space>d"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (2 / 4))]],
	from = "go-up",
	name = "recenter 2/4",
	keys = {{"n", "x"}, "<space><space>"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (3 / 4))]],
	from = "go-up",
	name = "recenter 3/4",
	keys = {{"n", "x"}, "<space>f"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (4 / 4))]],
	from = "go-up",
	name = "recenter 4/4",
	keys = {{"n", "x"}, "<space>g"},
})

require("luaexec").add({
	code =
[[
vim.api.nvim_create_augroup("cursor_lock", {clear = false})
-- create the augroup if it does not exist, else do nothing
if
	vim.tbl_isempty(
		vim.api.nvim_get_autocmds({group = "cursor_lock"})
	)
then
	local winline = vim.fn.winline()
	vim.api.nvim_create_autocmd(
		{
			"CursorMoved",
			"CursorMovedI",
			"WinScrolled",
		},
		{
			group = "cursor_lock",
			callback = function()
				require("go-up").recenter(winline)
			end,
		}
	)
else
	vim.api.nvim_clear_autocmds({group = "cursor_lock"})
end
]],
	from = "go-up",
	name = "recenter lock",
	keys = {{"n", "x"}, "<space><cr>"},
})

-- # setwinline

require("luaexec").add({
	code = [[require("go-up").setwinline(vim.api.nvim_win_get_height(0) * (0 / 4))]],
	from = "go-up",
	name = "setwinline 0/4",
	keys = {{"n", "x"}, "<cr>s"},
})
require("luaexec").add({
	code = [[require("go-up").setwinline(vim.api.nvim_win_get_height(0) * (1 / 4))]],
	from = "go-up",
	name = "setwinline 1/4",
	keys = {{"n", "x"}, "<cr>d"},
})
require("luaexec").add({
	code = [[require("go-up").setwinline(vim.api.nvim_win_get_height(0) * (2 / 4))]],
	from = "go-up",
	name = "setwinline 2/4",
	keys = {{"n", "x"}, "<cr><cr>"},
})
require("luaexec").add({
	code = [[require("go-up").setwinline(vim.api.nvim_win_get_height(0) * (3 / 4))]],
	from = "go-up",
	name = "setwinline 3/4",
	keys = {{"n", "x"}, "<cr>f"},
})
require("luaexec").add({
	code = [[require("go-up").setwinline(vim.api.nvim_win_get_height(0) * (4 / 4))]],
	from = "go-up",
	name = "setwinline 4/4",
	keys = {{"n", "x"}, "<cr>g"},
})
