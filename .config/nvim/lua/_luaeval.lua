require("luaeval").setup({
	hook_open = function()
		require("modexec").set_current_mode("luaeval")
		-- vim.cmd("$")
		-- vim.cmd("startinsert!")
	end,
	hook_close = function()
		-- vim.schedule(function()
		-- 	vim.api.nvim_feedkeys("", "n", false)
		-- end)
	end,
})

require("modexec").add_mode({
	name = "luaeval",
	chunks = {
		{
			code = [[require("luaeval").toggle()]],
			name = "window",
			gkey = {"n", "f:"},
		},
		{
			code = [[require("luaeval").eval()]],
			key = {"n", "r"},
		},
		{
			code = [[require("luaeval").eval({wrap = "vim.print"})]],
			key = {"n", "m"},
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
