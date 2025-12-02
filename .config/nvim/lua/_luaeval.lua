require("luaeval").setup({
	hook_bufadd = function()
		vim.schedule(function()
			local history = require("luaeval").list_history()
			if next(history) == nil then return end
			require("luaeval").buf_set_lines(history[1].chunk)
		end)

		vim.api.nvim_create_augroup("luaeval_config", {clear = true})
		vim.api.nvim_create_autocmd(
			"VimLeavePre",
			{
				group = "luaeval_config",
				pattern = "*",
				callback = function()
					require("luaeval").histadd()
				end,
			}
		)
	end,
	hook_open = function()
	end,
	hook_close = function()
	end,
})

require("luaexec").add({
	code = [[require("luaeval").toggle()]],
	from = "luaeval",
	name = "window",
	keys = {"n", "vi"},
})

require("luaexec").add({
	code = [[require("luaeval").eval()]],
	from = "luaeval",
	keys = {
		{{"n", "x"}, "m<bs>"},
		{{"n", "x", "s", "i", "c", "t", "o"}, "<f2>m<bs>"},
	},
})
