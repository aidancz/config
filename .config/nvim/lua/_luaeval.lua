require("luaeval").setup({
	hook_bufadd = function()
		vim.schedule(require("luaeval").load)

		vim.api.nvim_create_augroup("luaeval_config", {clear = true})
		vim.api.nvim_create_autocmd(
			"VimLeavePre",
			{
				group = "luaeval_config",
				pattern = "*",
				callback = function()
					require("luaeval").save()
				end,
			}
		)
	end,
	hook_open = function()
		vim.api.nvim_set_current_win(require("luaeval").cache.win_handle)
	end,
	hook_close = function()
	end,
})

require("luaexec").add({
	code = [[require("luaeval").open()]],
	from = "luaeval",
	name = "window",
	keys = {"n", "<cr>i"},
})

require("luaexec").add({
	code = [[require("luaeval").eval()]],
	from = "luaeval",
	keys = {
		{{"n", "x", "s", "i", "c", "t", "o"}, "<f2><tab>"},
	},
})
