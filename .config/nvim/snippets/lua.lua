-- # define snippets

local snippets = {}

-- # define add

local add = function(body, opts)
	opts = opts or {}
	table.insert(
		snippets,
		{
			body = body,
			prefix = opts.prefix,
			desc = opts.desc,
		}
	)
end

-- # add

add([[
local timer = vim.uv.new_timer()

local function toggle()
	if timer:is_active() then
		timer:stop()
	else
		timer:start(
			0,
			100,
			vim.schedule_wrap(function()
				print(os.time())
			end)
		)
	end
end

vim.keymap.set({ "n", "x", "s", "i", "c", "t", "o" }, "<del>", toggle)

toggle()
]])

-- # add

add([[
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
]])

-- # add

add([[
vim.keymap.set(
	{"n", "x", "s", "i", "c", "t", "o"},
	"<del>",
	function()
		print(os.time())
	end,
	{
		-- expr = true,
		-- remap = true,
	}
)
]])

-- # add

add([[
vim.api.nvim_create_augroup("test", {clear = true})
vim.api.nvim_create_autocmd(
	{
		"CursorMoved",
		"WinScrolled",
	},
	{
		group = "test",
		-- pattern = "*",
		callback = function(event)
			vim.print(event)
		end,
		-- once = true,
	}
)
]])

-- # add

add([=[
require("luaexec").add({
	-- code = [[print(os.time())]],
	code =
[[
print(os.time())
]],
	from = "default",
	name = "test",
	desc = "print time number",
	keys = {"n", "<c-s-t>"},
})
]=])

-- # return snippets

return snippets
