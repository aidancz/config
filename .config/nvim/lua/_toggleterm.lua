vim.pack.add({
	"https://github.com/akinsho/toggleterm.nvim",
})

require("toggleterm").setup({
	direction = "float",
	float_opts = {
		border = "none",
		row = 0,
		col = 0,
		width = vim.o.columns,
		height = vim.o.lines - 2,
		zindex = 201,
	},
})

require("toggleterm").registry = {}

-- # lazygit

--[=[

local lazygit = require("toggleterm.terminal").Terminal:new({
	cmd = "lazygit",
	-- hidden = true,
	-- close_on_exit = true,
	on_close = function()
		vim.cmd("checktime")
		-- reload buffers
	end,
})
require("toggleterm").registry.lazygit = function()
	lazygit:toggle()
end

require("luaexec").add({
	code = [[require("toggleterm").registry.lazygit()]],
	from = "toggleterm",
	name = "lazygit",
	keys = {{"n", "x", "s", "i", "c", "t", "o"}, "<f2>x"},
})

--]=]

-- # yazi

local yazi = require("toggleterm.terminal").Terminal:new({
	cmd = "yazi",
	-- on_close = function()
	-- 	vim.cmd("checktime")
	-- end,
})
require("toggleterm").registry.yazi = function()
	yazi:toggle()
end

require("luaexec").add({
	code = [[require("toggleterm").registry.yazi()]],
	from = "toggleterm",
	name = "yazi",
	keys = {{"n", "x", "s", "i", "c", "t", "o"}, "<f2>f"},
})

-- # tig

local tig = require("toggleterm.terminal").Terminal:new({
	cmd = "tig",
	on_close = function()
		vim.cmd("checktime")
	end,
})
require("toggleterm").registry.tig = function()
	tig:toggle()
end

require("luaexec").add({
	code = [[require("toggleterm").registry.tig()]],
	from = "toggleterm",
	name = "tig",
	keys = {{"n", "x", "s", "i", "c", "t", "o"}, "<f2>t"},
})
