-- require("mini.deps").add({
-- 	source = "aidancz/go-up.nvim",
-- })

require("go-up").setup({
})

-- # virtual lines

require("luaexec").add({
	code = [[require("go-up").toggle()]],
	from = "go-up",
})

-- # recenter

require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (0 / 4))]],
	from = "go-up",
	name = "recenter 0/4",
	keys = {"n", "fj"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (1 / 4))]],
	from = "go-up",
	name = "recenter 1/4",
	keys = {"n", "fh"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (2 / 4))]],
	from = "go-up",
	name = "recenter 2/4",
	keys = {"n", "fm"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (3 / 4))]],
	from = "go-up",
	name = "recenter 3/4",
	keys = {"n", "fl"},
})
require("luaexec").add({
	code = [[require("go-up").recenter(vim.api.nvim_win_get_height(0) * (4 / 4))]],
	from = "go-up",
	name = "recenter 4/4",
	keys = {"n", "fk"},
})

require("luaexec").add({
	code =
[[
vim.api.nvim_create_augroup("cursor_center", {clear = false})
-- create the augroup if it does not exist, else do nothing
if
	next(
		vim.api.nvim_get_autocmds({group = "cursor_center"})
	) == nil
then
	vim.api.nvim_create_autocmd(
		{
			"CursorMoved",
			"CursorMovedI",
			"WinScrolled",
		},
		{
			group = "cursor_center",
			callback = function()
				require("luaexec").registry["go-up"]["recenter 2/4"]()
			end,
		}
	)
	vim.api.nvim_exec_autocmds("CursorMoved", {group = "cursor_center"})
else
	vim.api.nvim_clear_autocmds({group = "cursor_center"})
end
]],
	from = "go-up",
	name = "recenter 2/4 lock",
	keys = {"n", "fn"},
})

-- # align

require("luaexec").add({
	code = [[require("go-up").align()]],
	from = "go-up",
	name = "align",
	keys = {"n", "ff"},
})

-- # scroll

require("luaexec").add({
	code = [[require("go-up").scroll(vim.api.nvim_win_get_height(0) * (1 / 4), true)]],
	from = "go-up",
	name = "scroll +1/4",
})
require("luaexec").add({
	code = [[require("go-up").scroll(-vim.api.nvim_win_get_height(0) * (1 / 4), true)]],
	from = "go-up",
	name = "scroll -1/4",
})
require("luaexec").add({
	code = [[require("go-up").scroll(vim.api.nvim_win_get_height(0) * (2 / 4), true)]],
	from = "go-up",
	name = "scroll +2/4",
})
require("luaexec").add({
	code = [[require("go-up").scroll(-vim.api.nvim_win_get_height(0) * (2 / 4), true)]],
	from = "go-up",
	name = "scroll -2/4",
})
require("luaexec").add({
	code = [[require("go-up").scroll(vim.api.nvim_win_get_height(0) * (4 / 4), true)]],
	from = "go-up",
	name = "scroll +4/4",
})
require("luaexec").add({
	code = [[require("go-up").scroll(-vim.api.nvim_win_get_height(0) * (4 / 4), true)]],
	from = "go-up",
	name = "scroll -4/4",
})

require("luaexec").add({
	code = [[require("go-up").scroll(1, false)]],
	from = "go-up",
	name = "scroll +1",
})
require("luaexec").add({
	code = [[require("go-up").scroll(-1, false)]],
	from = "go-up",
	name = "scroll -1",
})
