-- affect vim.api.nvim_list_wins: https://github.com/neovim/neovim/issues/34295
-- affect <c-f>/<c-b> "When there is only one window the 'window' option might be used." since there are many floating windows

require("vim._extui").enable({
	enable = true,
	msg = {
		target = "cmd",
		-- target = "msg",
		timeout = 4000,
	},
})
