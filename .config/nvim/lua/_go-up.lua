vim.opt.runtimepath:prepend("~/sync_git/go-up.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/go-up.nvim",
-- })

require("go-up").setup({
})

vim.keymap.set({"n", "x"}, "zz", require("go-up").new_zz)
vim.keymap.set({"n", "x"}, "zb", function()
		vim.cmd("normal! zb")
		require("go-up").redraw()
	end)

vim.keymap.set({"n", "x"}, "<c-g>", require("go-up").align)



local scroll = function(n, follow)
	local scroll_down
	local scroll_up
	if follow then
		scroll_down = ""
		scroll_up = ""
	else
		scroll_down = ""
		scroll_up = ""
	end

	if n == 0 then
		return
	elseif n > 0 then
		vim.cmd("normal!" .. n .. scroll_down)
	elseif n < 0 then
		vim.cmd("normal!" .. -n .. scroll_up)
	end
end

local scroll_wrapper = function(n)
	if n == 0 then return end

	local blank_top    = require("go-up").count_blank_top()
	local blank_bottom = require("go-up").count_blank_bottom()

	if
		blank_top == 0
		and
		blank_bottom == 0
	then
		scroll(n, false)
		if n < 0 then require("go-up").align_top() end
	else
		if n > 0 and blank_top ~= 0 then
			scroll(math.min(blank_top, n), true)
		elseif n < 0 and blank_bottom ~= 0 then
			scroll(math.max(-blank_bottom, n), true)
		else
			scroll(n, true)
		end
	end
end

vim.keymap.set({"n", "x"}, "<c-n>", function()
		local count = math.floor(vim.api.nvim_win_get_height(0)/4)
		scroll_wrapper(count)
	end)
vim.keymap.set({"n", "x"}, "<c-p>", function()
		local count = math.floor(vim.api.nvim_win_get_height(0)/4)
		scroll_wrapper(-count)
	end)
vim.keymap.set({"n", "x"}, "<c-d>", function()
		local count = math.floor(vim.api.nvim_win_get_height(0)/2)
		scroll_wrapper(count)
	end)
vim.keymap.set({"n", "x"}, "<c-u>", function()
		local count = math.floor(vim.api.nvim_win_get_height(0)/2)
		scroll_wrapper(-count)
	end)
vim.keymap.set({"n", "x"}, "<c-f>", function()
		local count = math.floor(vim.api.nvim_win_get_height(0)/1)
		scroll_wrapper(count)
	end)
vim.keymap.set({"n", "x"}, "<c-b>", function()
		local count = math.floor(vim.api.nvim_win_get_height(0)/1)
		scroll_wrapper(-count)
	end)



local create_autocmd = function()
	local cursor_center_augroup = vim.api.nvim_create_augroup("cursor_center", {clear = true})
	vim.api.nvim_create_autocmd(
		{"CursorMoved", "CursorMovedI", "WinScrolled"},
		{
			group = cursor_center_augroup,
			command = "silent! normal zz",
		})
end

vim.keymap.set(
	{"n", "x"},
	"<a-s>",
	function()
		if
			pcall(function()
				vim.api.nvim_get_autocmds({group = "cursor_center"})
			end)
		then
			vim.api.nvim_del_augroup_by_name("cursor_center")
		else
			create_autocmd()
			vim.api.nvim_exec_autocmds({"CursorMoved"}, {})
		end
	end
)
