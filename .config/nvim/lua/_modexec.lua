-- # add mode

require("modexec").add_mode({
	name = "example",
	chunks = {
		{
			code =
[[
local config = {
	count = vim.v.count,
	time = os.time(),
}
vim.notify(vim.inspect(config))
]],
			name = "inspect_config",
			key = {"n", "r"},
		},
	},
})
require("modexec").set_current_mode("example")



-- require("modexec").add_mode({
-- 	name = "buffer",
-- 	setup = function(self)
-- 		vim.keymap.set("n", "r", "[b", {remap = true})
-- 		vim.keymap.set("n", "m", "]b", {remap = true})
-- 	end,
-- })



require("modexec").add_mode({
	name = "buffer",
	chunks = {
		{
			code =
[[
local count = vim.v.count
if count == 0 then count = 1 end

local buf = vim.api.nvim_get_current_buf()
local buf_list = vim.api.nvim_list_bufs()
local buf_is_listed = function(buf)
	if buf == 0 then return false end
	-- https://github.com/neovim/neovim/issues/33270
	return vim.fn.buflisted(buf) ~= 0
end

local prev
prev = function(buf)
	if buf_is_listed(buf - 1) then
		return (buf - 1)
	end
	if (buf - 1) < buf_list[1] then
		return prev(buf_list[#buf_list] + 1)
	end
	return prev(buf - 1)
end
for i = 1, count do
	buf = prev(buf)
end
vim.api.nvim_set_current_buf(buf)
]],
			name = "prev",
			key = {"n", "r"},
		},
		{
			code =
[[
local count = vim.v.count
if count == 0 then count = 1 end

local buf = vim.api.nvim_get_current_buf()
local buf_list = vim.api.nvim_list_bufs()
local buf_is_listed = function(buf)
	if buf == 0 then return false end
	-- https://github.com/neovim/neovim/issues/33270
	return vim.fn.buflisted(buf) ~= 0
end

local next
next = function(buf)
	if buf_is_listed(buf + 1) then
		return (buf + 1)
	end
	if (buf + 1) > buf_list[#buf_list] then
		return next(buf_list[1] - 1)
	end
	return next(buf + 1)
end
for i = 1, count do
	buf = next(buf)
end
vim.api.nvim_set_current_buf(buf)
]],
			name = "next",
			key = {"n", "m"},
		},
	},
})



require("modexec").add_mode({
	name = "window",
	chunks = {
		{
			code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd W")
]],
			name = "prev",
			key = {"n", "r"},
		},
		{
			code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd w")
]],
			name = "next",
			key = {"n", "m"},
		},
	},
})



require("modexec").add_mode({
	name = "undo",
	setup = function(self)
		vim.keymap.set("n", "r", "<c-r>")
	end,
})

-- # keymap

vim.keymap.set(
	"n",
	"fj",
	function()
		require("modexec").set_current_mode("buffer")
	end
)

vim.keymap.set(
	"n",
	"fk",
	function()
		require("modexec").set_current_mode("window")
	end
)

vim.keymap.set(
	"n",
	"u",
	function()
		require("modexec").set_current_mode("undo")
		return "u"
	end,
	{
		expr = true,
	}
)
