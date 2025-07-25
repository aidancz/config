local M = {}

M.cache = {
	original_virtualedit = nil,
	modechanged_cursor_pos = {
		lnum = 1,
		virtcol = 1,
	},
}

M.setup = function()
	M.cache.original_virtualedit = vim.o.virtualedit
	M.on()
end

-- # insertleave_cursor

M.insertleave_cursor_on = function()
	vim.api.nvim_create_augroup("virtualedit_all_insertleave_cursor", {clear = true})
	vim.api.nvim_create_autocmd(
		{
			"InsertLeave",
		},
		{
			group = "virtualedit_all_insertleave_cursor",
			callback = function()
				-- vim.schedule(function()
				-- 	pcall(function()
				-- 		vim.cmd("normal! `^")
				-- 	end)
				-- end)

				-- vim.cmd("normal! `^")
				-- NOTE: does not work well with modechanged autocmd below when `cc aidan <esc>`, don't know why

				local pos = vim.fn.getpos("'^")
				table.remove(pos, 1)
				vim.fn.cursor(pos)
			end,
		}
	)
end

M.insertleave_cursor_off = function()
	vim.api.nvim_del_augroup_by_name("virtualedit_all_insertleave_cursor")
end

M.insertleave_cursor_is_on = function()
	return
	pcall(
		function()
			vim.api.nvim_get_autocmds({group = "virtualedit_all_insertleave_cursor"})
		end
	)
end

M.insertleave_cursor_tog = function()
	if
		M.insertleave_cursor_is_on()
	then
		M.insertleave_cursor_off()
	else
		M.insertleave_cursor_on()
	end
end

-- # modechanged

M.modechanged_cursor_record = function()
	M.cache.modechanged_cursor_pos = require("virtcol").get_cursor()
end

M.modechanged_cursor_restore = function()
	vim.cmd([[normal! m']])
	-- https://stackoverflow.com/questions/27193867/vim-how-can-i-put-my-current-position-in-jumplist
	require("virtcol").set_cursor(M.cache.modechanged_cursor_pos)
end

M.modechanged_on = function()
-- `vim.o.virtualedit = "all"` is not apropriate for other mode than normal mode
	vim.api.nvim_create_augroup("virtualedit_all_modechanged", {clear = true})
	vim.api.nvim_create_autocmd(
		{
			"ModeChanged",
		},
		{
			group = "virtualedit_all_modechanged",
			pattern = "n:*",
			callback = function()
				M.modechanged_cursor_record()
				vim.o.virtualedit = "onemore"
			end,
		}
	)
	vim.api.nvim_create_autocmd(
		{
			"ModeChanged",
		},
		{
			group = "virtualedit_all_modechanged",
			pattern = "*:n",
			callback = function()
				vim.o.virtualedit = "all"
			end,
		}
	)
end

M.modechanged_off = function()
	vim.api.nvim_del_augroup_by_name("virtualedit_all_modechanged")
end

M.modechanged_is_on = function()
	return
	pcall(
		function()
			vim.api.nvim_get_autocmds({group = "virtualedit_all_modechanged"})
		end
	)
end

M.modechanged_tog = function()
	if
		M.modechanged_is_on()
	then
		M.modechanged_off()
	else
		M.modechanged_on()
	end
end

-- # paste

M.paste_on = function()
	local map = function(mode, lhs, paste_key)
		vim.keymap.set(
			mode,
			lhs,
			function()
				vim.o.virtualedit = "onemore"
				vim.schedule(function()
					vim.o.virtualedit = "all"
				end)
				return paste_key
			end,
			{
				expr = true,
			}
		)
	end
	map({"n", "x"}, "p", "<Plug>(YankyPutAfter)")
	map({"n", "x"}, "P", "<Plug>(YankyPutBefore)")
	map({"n", "x"}, "gp", "<Plug>(YankyGPutAfter)")
	map({"n", "x"}, "gP", "<Plug>(YankyGPutBefore)")
end

M.paste_off = function()
	vim.api.nvim_del_keymap("n", "p")
	vim.api.nvim_del_keymap("n", "P")
	vim.api.nvim_del_keymap("n", "gp")
	vim.api.nvim_del_keymap("n", "gP")
	vim.api.nvim_del_keymap("x", "p")
	vim.api.nvim_del_keymap("x", "P")
	vim.api.nvim_del_keymap("x", "gp")
	vim.api.nvim_del_keymap("x", "gP")
end

M.paste_is_on = function()
	local output = vim.api.nvim_exec2("nmap p", {output = true}).output
	local start = string.find(output, "No mapping found")
	return start == nil
end

M.paste_tog = function()
	if
		M.paste_is_on()
	then
		M.paste_off()
	else
		M.paste_on()
	end
end

-- # M.on M.off M.tog

M.on = function()
	vim.o.virtualedit = "all"

	M.insertleave_cursor_on()
	M.modechanged_on()
	M.paste_on()
end

M.off = function()
	M.insertleave_cursor_off()
	M.modechanged_off()
	M.paste_off()

	vim.o.virtualedit = M.cache.original_virtualedit
end

M.is_on = function()
	return
	M.insertleave_cursor_is_on()
	and
	M.modechanged_is_on()
	and
	M.paste_is_on()
end

M.tog = function()
	if
		M.is_on()
	then
		M.off()
	else
		M.on()
	end
end

return M
