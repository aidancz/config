vim.o.virtualedit = "all"

-- # fix cursor position when changing mode

vim.api.nvim_create_augroup("switch_mode_cursor_position", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"InsertLeave",
	},
	{
		group = "switch_mode_cursor_position",
		callback = function()
			vim.cmd("normal! `^")
		end,
	}
)

-- # fix `virtualedit=all` mode

local pos0 = {
	lnum = 1,
	virtcol = 1,
}
local pos1 = {
	lnum = 1,
	virtcol = 1,
}

local cursor_record = function(pos)
	pos.lnum, pos.virtcol = require("virtcol").get_cursor()
end

local cursor_restore = function(pos)
	require("virtcol").set_cursor(pos.lnum, pos.virtcol)
end

vim.keymap.set({"n", "x"}, "fo", function() cursor_restore(pos0) end)
vim.keymap.set({"n", "x"}, "fi", function() cursor_restore(pos1) end)

vim.api.nvim_create_augroup("virtualedit_all", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"ModeChanged",
	},
	{
		group = "virtualedit_all",
		pattern = "n:*",
		callback = function()
			cursor_record(pos0)
			vim.o.virtualedit = "onemore"
		end,
	}
)
vim.api.nvim_create_autocmd(
	{
		"ModeChanged",
	},
	{
		group = "virtualedit_all",
		pattern = "*:n",
		callback = function()
			local timer = vim.uv.new_timer()
			timer:start(
				0,
				10,
				vim.schedule_wrap(function()
					if vim.api.nvim_get_mode().mode == "n" then
						cursor_record(pos1)
						vim.o.virtualedit = "all"
						timer:stop()
					end
				end)
			)
		end,
	}
)

-- # fix `virtualedit=all` paste

vim.keymap.set(
	"n",
	"p",
	function()
		vim.o.virtualedit = "onemore"
		vim.schedule(function()
			vim.o.virtualedit = "all"
		end)
		return "p"
	end,
	{expr = true}
)
vim.keymap.set(
	"n",
	"P",
	function()
		vim.o.virtualedit = "onemore"
		vim.schedule(function()
			vim.o.virtualedit = "all"
		end)
		return "P"
	end,
	{expr = true}
)
