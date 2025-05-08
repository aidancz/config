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

require("luaexec").add_mode({
	name = "luaeval",
	chunks = {
		{
			code = [[require("luaeval").toggle()]],
			name = "window",
			gkey = {"n", "fi"},
		},
		{
			code = [[require("luaeval").eval()]],
			lkey = {"n", "r"},
		},
		{
			code = [[require("luaeval").eval({wrap = "vim.print"})]],
			lkey = {"n", "m"},
		},
		{
			code = [[require("luaeval").eval({wrap = "vim.cmd"})]],
		},
		{
			code = [[require("luaeval").eval({wrap = "vim.cmd.normal"})]],
		},
		{
			code = [[require("luaeval").eval({wrap = "vim.api.nvim_feedkeys"})]],
		},
	},
})
