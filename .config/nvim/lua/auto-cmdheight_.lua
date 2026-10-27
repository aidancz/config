vim.pack.add({
	"https://github.com/jake-stewart/auto-cmdheight.nvim",
})

require("auto-cmdheight").setup({
	max_lines = vim.o.lines - 2,
	duration = 0,
	remove_on_key = true,
	clear_always = true,
})
