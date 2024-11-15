-- https://github.com/echasnovski/mini.nvim/issues/990

local M = {}

M.extmark_ns_id = vim.api.nvim_create_namespace("M_extmark")

M.extmark_opts = {
	virt_text = {{"○", "EolExtmark"}},
	virt_text_pos = "overlay",
}

M.extmark_id = nil

M.show_at_cursor_line = function(args)
	if vim.api.nvim_get_current_buf() ~= args.buf then return end
	M.extmark_opts.id = M.extmark_id
	local line = vim.fn.line(".") - 1
	M.extmark_id = vim.api.nvim_buf_set_extmark(args.buf, M.extmark_ns_id, line, -1, M.extmark_opts)
end

return M
