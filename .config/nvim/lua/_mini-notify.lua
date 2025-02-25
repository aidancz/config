require("mini.deps").add({
	source = "echasnovski/mini.notify",
})

require("mini.notify").setup({
	window = {
		winblend = 0,
	},
})

vim.notify = require("mini.notify").make_notify()
