-- # example

require("luaexec").add({
	code = [[vim.notify(vim.system({"date", "--iso-8601=ns"}):wait().stdout)]],
	from = "example",
	name = "print_time",
	desc = "shows a nanosecond-precision timestamp in a neovim notification",
	keys = {"n", "<c-s-t>"},
})

--[[
chunk.code: required
chunk.from: optional
chunk.name: optional
chunk.desc: optional
chunk.keys: optional
--]]

require("luaexec").add({
	code = [[vim.notify(tostring(vim.v.count))]],
	from = "example",
})

-- # buffer

require("luaexec").add({
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
	from = "buffer",
	name = "prev",
	keys = {"n", "mB"},
})

require("luaexec").add({
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
	from = "buffer",
	name = "next",
	keys = {"n", "mb"},
})

-- # window

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd W")
]],
	from = "window",
	name = "prev",
	keys = {"n", "mW"},
})

require("luaexec").add({
	code =
[[
local count = vim.v.count
if count == 0 then count = "" end
vim.cmd(count .. "wincmd w")
]],
	from = "window",
	name = "next",
	keys = {"n", "mw"},
})
