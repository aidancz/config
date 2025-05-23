local contents =
{
----------------------------------------------------------------
	{
		body =
[[
local timer = vim.uv.new_timer()
local running = false

local start = function()
	timer:start(
		0,
		100,
		vim.schedule_wrap(function()
			print(os.time())
		end)
	)
	running = true
end
local stop = function()
	timer:stop()
	running = false
end
local toggle = function()
	if running then stop() else start() end
end

vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<del>",
	toggle
)

start()
]],
	},
----------------------------------------------------------------
	{
		body =
[[
vim.api.nvim_open_win(
	0,
	true,
	{
		relative = "editor",
		anchor = "NW",
		border = "none",
		row = 0,
		col = 0,
		width = math.floor(vim.o.columns / 4),
		height = math.floor(vim.o.lines / 4),
		style = "minimal",
	}
)
]],
	},
----------------------------------------------------------------
	{
		body =
[[
vim.keymap.set(
	{"n", "x"},
	-- {"n", "x", "s", "i", "c", "t", "o"},
	"e",
	function()
		print(os.time())
	end,
	{
		-- expr = true,
		-- remap = true,
	}
)
]],
	},
----------------------------------------------------------------
	{
		body =
[[
vim.api.nvim_create_augroup("test", {clear = true})
vim.api.nvim_create_autocmd(
	{
		"CursorMoved",
		"WinScrolled",
	},
	{
		group = "test",
		-- pattern = "*",
		callback = function()
			print(os.time())
		end,
		-- once = true,
	}
)
]],
	},
----------------------------------------------------------------
	{
		body =
[=[
require("luaexec").add({
	code = [[print(os.time())]],
	from = "default",
	name = "test",
	desc = "print time number",
	lkey = {"n", "r"},
	gkey = {"n", "<c-s-t>"},
})
]=],
	},
----------------------------------------------------------------
}

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

for _, i in ipairs(contents) do
	if string.sub(i.body, -1, -1) == "\n" then
		i.body = string.sub(i.body, 1, -2)
	end
	if i.prefix == nil then
		i.prefix = ""
	end
	if i.desc == nil then
		i.desc = ""
	end
end

return contents
