require("mini.deps").add({
	source = "akinsho/toggleterm.nvim",
})

require("toggleterm").setup({
	direction = "float",
	float_opts = {
		border = "none",
		row = 0,
		col = 0,
		width = vim.o.columns,
		height = vim.o.lines,
	},
})

require("toggleterm").registry = {}

-- # lazygit

local lazygit = require("toggleterm.terminal").Terminal:new({
	cmd = "lazygit",
})
require("toggleterm").registry.lazygit = function()
	lazygit:toggle()
end

require("luaexec").add({
	code = [[require("toggleterm").registry.lazygit()]],
	from = "toggleterm",
	name = "lazygit",
	keys = {"n", "<f2>g"},
})
