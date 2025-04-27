return
{
	{
		body =
([[
local timer = vim.uv.new_timer()
timer:start(
	0,
	10,
	vim.schedule_wrap(function()
		print(os.time())
	end)
)
]]):sub(1, -2),
	},
	{
		body =
([[
local border_offset
local winborder = vim.o.winborder
if winborder == "" or winborder == "none" then
	border_offset = 0
else
	border_offset = 2
end
vim.api.nvim_open_win(
	0,
	true,
	{
		relative = "editor",
		anchor = "NW",
		row = 0,
		col = 0,
		width = vim.o.columns - border_offset,
		height = vim.o.lines - vim.o.cmdheight - border_offset,
	}
)
]]):sub(1, -2),
	},
	{
		body =
([[
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
]]):sub(1, -2),
	},
	{
		body =
([[
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
]]):sub(1, -2),
	},
}
