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

local M = {}

M.pos = {
	lnum = 1,
	virtcol = 1,
}

M.cursor_record = function()
	M.pos = require("virtcol").get_cursor()
end

M.cursor_restore = function()
	require("virtcol").set_cursor(M.pos)
end

vim.keymap.set(
	{"n", "x"},
	"fo",
	function()
		vim.cmd([[normal! m']])
		-- https://stackoverflow.com/questions/27193867/vim-how-can-i-put-my-current-position-in-jumplist
		M.cursor_restore()
	end
)

vim.api.nvim_create_augroup("virtualedit_all", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"ModeChanged",
	},
	{
		group = "virtualedit_all",
		pattern = "n:*",
		callback = function()
			M.cursor_record()
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
