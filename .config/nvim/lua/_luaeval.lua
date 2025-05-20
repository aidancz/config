require("luaeval").setup({
	hook_open = function()
		require("luaexec").set_current_mode("luaeval")
		-- vim.cmd("$")
		-- vim.cmd("startinsert!")
	end,
	hook_close = function()
		-- vim.schedule(function()
		-- 	vim.api.nvim_feedkeys("", "n", false)
		-- end)
	end,
})

require("luaexec").add({
	code = [[require("luaeval").toggle()]],
	from = "luaeval",
	name = "window",
	gkey = {"n", "fi"},
})

require("luaexec").add({
	code = [[require("luaeval").eval()]],
	from = "luaeval",
	lkey = {"n", "r"},
})

require("luaexec").add({
	code = [[require("luaeval").eval({wrap = "vim.print"})]],
	from = "luaeval",
	lkey = {"n", "m"},
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
