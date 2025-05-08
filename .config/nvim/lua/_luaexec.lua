-- # example

require("luaexec").add_mode({
	name = "example",
	chunks = {
		{
			code = [[vim.notify(vim.system({"date", "--iso-8601=ns"}):wait().stdout)]],
			from = "example",
			name = "print_time",
			desc = "shows a nanosecond-precision timestamp in a neovim notification",
			lkey = {"n", "r"},
			gkey = {"n", "<c-s-t>"},
		},
		{
			code = [[vim.notify(tostring(vim.v.count))]],
			lkey = {"n", "m"},
		},
	},
})
--[[
chunk.code: required
chunk.from: not required, add automatically
chunk.name: optional
chunk.desc: optional
chunk.lkey: optional, means local key, {code = ..., lkey = ..., lkey_another = ...} is okay, as long as the prefix is "lkey"
chunk.gkey: optional, means global key, {code = ..., gkey = ..., gkey_another = ...} is okay, as long as the prefix is "gkey"
--]]
require("luaexec").set_current_mode("example")

-- # buffer

require("luaexec").add_mode({
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
			lkey = {"n", "r"},
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
			lkey = {"n", "m"},
		},
	},
})

-- # window

require("luaexec").add_mode({
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
			lkey = {"n", "r"},
		},
		{
			code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd w")
]],
			name = "next",
			lkey = {"n", "m"},
		},
	},
})

-- # luaexec
-- yes, luaexec itself can be a mode

require("luaexec").add_mode({
	name = "luaexec",
	chunks = {
		{
			code = [[require("luaexec").set_current_mode("buffer")]],
			gkey = {"n", "fs"},
		},
		{
			code = [[require("luaexec").set_current_mode("window")]],
			gkey = {"n", "fw"},
		},
	},
})
