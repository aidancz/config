require("mini.deps").add({
	source = "mikavilpas/yazi.nvim",
})

require("yazi").setup({
	floating_window_scaling_factor = 1,
	keymaps = {
		show_help                            = false,
		open_file_in_vertical_split          = "<c-v>",
		open_file_in_horizontal_split        = "<c-s>",
		open_file_in_tab                     = "<c-t>",
		grep_in_directory                    = false,
		replace_in_directory                 = false,
		cycle_open_buffers                   = "<tab>",
		copy_relative_path_to_selected_files = "<c-y>",
		send_to_quickfix_list                = "<c-q>",
		change_working_directory             = false,
	},
	yazi_floating_window_border = vim.co.border,
	clipboard_register = "+",
	-- hooks = {
	-- 	yazi_opened = function()
	-- 		vim.o.cmdheight = 0
	-- 	end,
	-- 	yazi_closed_successfully = function()
	-- 		vim.o.cmdheight = 1
	-- 	end,
	-- },
})

vim.keymap.set({"n"}, "<a-f>", require("yazi").yazi)

vim.api.nvim_create_augroup("yazi_config", {clear = true})
vim.api.nvim_create_autocmd(
	"BufEnter",
	{
		group = "yazi_config",
		callback = function()
			vim.schedule(function()
				if vim.bo.filetype == "yazi" then
					vim.opt.cmdheight = 0
				else
					vim.opt.cmdheight = 1
				end
			end)
		end,
	}
)
