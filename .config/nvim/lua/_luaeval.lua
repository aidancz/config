require("luaeval").setup({
	hook_open = function()
	end,
	hook_close = function()
	end,
})

require("luaexec").add({
	code = [[require("luaeval").toggle()]],
	from = "luaeval",
	name = "window",
	keys = {"n", "ri"},
})

require("luaexec").add({
	code = [[require("luaeval").eval()]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval({wrap = "vim.print"})]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval({wrap = "vim.cmd"})]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval({wrap = "vim.cmd.normal"})]],
	from = "luaeval",
})

require("luaexec").add({
	code = [[require("luaeval").eval({wrap = "vim.api.nvim_feedkeys"})]],
	from = "luaeval",
})
