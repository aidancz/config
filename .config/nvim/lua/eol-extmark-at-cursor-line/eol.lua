-- https://github.com/echasnovski/mini.nvim/issues/990

local eol = {}

eol.extmark_ns_id = vim.api.nvim_create_namespace("eol_extmark")

eol.extmark_opts = {
	virt_text = {{"○", "EolExtmark"}},
	virt_text_pos = "overlay",
}

eol.extmark_id = nil

eol.show_at_cursor_line = function(args)
	if vim.api.nvim_get_current_buf() ~= args.buf then return end
	eol.extmark_opts.id = eol.extmark_id
	local line = vim.fn.line(".") - 1
	eol.extmark_id = vim.api.nvim_buf_set_extmark(args.buf, eol.extmark_ns_id, line, -1, eol.extmark_opts)
end

return eol
