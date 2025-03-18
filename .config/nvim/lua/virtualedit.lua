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

vim.api.nvim_create_augroup("virtualedit_all", {clear = true})

vim.api.nvim_create_autocmd(
	{
		"ModeChanged",
	},
	{
		group = "virtualedit_all",
		pattern = "n:*",
		callback = function()
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
		callback = vim.schedule_wrap(function()
			if vim.api.nvim_get_mode().mode ~= "n" then return end
			-- `vib` of `mini.ai` actually quit and reenter visual mode, prevent this situation
			vim.o.virtualedit = "all"
		end),
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
