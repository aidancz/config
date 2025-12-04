-- require("mini.deps").add({
-- 	source = "aidancz/paramo.nvim",
-- 	depends = {
-- 		{
-- 			source = "aidancz/virtcol.nvim",
-- 		},
-- 	},
-- })

local get_expr_func = function(direction, is, hook)
	return
	function()
		return
		require("paramo").expr({
			direction = direction,
			is = is,
			hook = hook,
		})
	end
end

-- # para_nonempty_reverse

vim.keymap.set({"n", "x", "o"}, "}", get_expr_func("next", require("para_nonempty_reverse").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "{", get_expr_func("prev", require("para_nonempty_reverse").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, ")", get_expr_func("next", require("para_nonempty_reverse").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "(", get_expr_func("prev", require("para_nonempty_reverse").is_tail), {expr = true})

-- # para_nonempty

vim.keymap.set({"n", "x", "o"}, "vj", get_expr_func("next", require("para_nonempty").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vk", get_expr_func("prev", require("para_nonempty").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vl", get_expr_func("next", require("para_nonempty").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vh", get_expr_func("prev", require("para_nonempty").is_tail), {expr = true})

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "v",
-- 	heads = {
-- 		{"j", get_expr_func("next", require("para_nonempty").is_head), {expr = true}},
-- 		{"k", get_expr_func("prev", require("para_nonempty").is_head), {expr = true}},
-- 	},
-- })
-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "v",
-- 	heads = {
-- 		{"l", get_expr_func("next", require("para_nonempty").is_tail), {expr = true}},
-- 		{"h", get_expr_func("prev", require("para_nonempty").is_tail), {expr = true}},
-- 	},
-- })

-- # para_cursor_column

vim.keymap.set({"n", "x", "o"}, "mf", get_expr_func("next", require("para_cursor_column").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "md", get_expr_func("prev", require("para_cursor_column").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mg", get_expr_func("next", require("para_cursor_column").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ms", get_expr_func("prev", require("para_cursor_column").is_tail), {expr = true})

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "m",
-- 	heads = {
-- 		{"f", get_expr_func("next", require("para_cursor_column").is_head), {expr = true}},
-- 		{"d", get_expr_func("prev", require("para_cursor_column").is_head), {expr = true}},
-- 	},
-- })
-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "m",
-- 	heads = {
-- 		{"g", get_expr_func("next", require("para_cursor_column").is_tail), {expr = true}},
-- 		{"s", get_expr_func("prev", require("para_cursor_column").is_tail), {expr = true}},
-- 	},
-- })

-- # para_cursor_indent

-- local caret = function() vim.cmd("normal! ^") end

vim.keymap.set({"n", "x", "o"}, "ef", get_expr_func("next", require("para_cursor_indent").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ed", get_expr_func("prev", require("para_cursor_indent").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "eg", get_expr_func("next", require("para_cursor_indent").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "es", get_expr_func("prev", require("para_cursor_indent").is_tail), {expr = true})

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "e",
-- 	heads = {
-- 		{"f", get_expr_func("next", require("para_cursor_indent").is_head), {expr = true}},
-- 		{"d", get_expr_func("prev", require("para_cursor_indent").is_head), {expr = true}},
-- 	},
-- })
-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "e",
-- 	heads = {
-- 		{"g", get_expr_func("next", require("para_cursor_indent").is_tail), {expr = true}},
-- 		{"s", get_expr_func("prev", require("para_cursor_indent").is_tail), {expr = true}},
-- 	},
-- })

-- # para_cursor_indent_include_empty_line lt

local para_cursor_indent_include_empty_line_is_head_lt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_head(
		pos,
		function(a, b)
			return a < b
		end
	)
end
local para_cursor_indent_include_empty_line_is_tail_lt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_tail(
		pos,
		function(a, b)
			return a < b
		end
	)
end

vim.keymap.set({"n", "x", "o"}, "vf", get_expr_func("next", para_cursor_indent_include_empty_line_is_head_lt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vd", get_expr_func("prev", para_cursor_indent_include_empty_line_is_head_lt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vg", get_expr_func("next", para_cursor_indent_include_empty_line_is_tail_lt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vs", get_expr_func("prev", para_cursor_indent_include_empty_line_is_tail_lt), {expr = true})

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "v",
-- 	heads = {
-- 		{"f", get_expr_func("next", para_cursor_indent_include_empty_line_is_head_lt), {expr = true}},
-- 		{"d", get_expr_func("prev", para_cursor_indent_include_empty_line_is_head_lt), {expr = true}},
-- 	},
-- })
-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "v",
-- 	heads = {
-- 		{"g", get_expr_func("next", para_cursor_indent_include_empty_line_is_tail_lt), {expr = true}},
-- 		{"s", get_expr_func("prev", para_cursor_indent_include_empty_line_is_tail_lt), {expr = true}},
-- 	},
-- })

-- # para_cursor_indent_include_empty_line gt

local para_cursor_indent_include_empty_line_is_head_gt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_head(
		pos,
		function(a, b)
			return a > b
		end
	)
end
local para_cursor_indent_include_empty_line_is_tail_gt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_tail(
		pos,
		function(a, b)
			return a > b
		end
	)
end

vim.keymap.set({"n", "x", "o"}, "mj", get_expr_func("next", para_cursor_indent_include_empty_line_is_head_gt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mk", get_expr_func("prev", para_cursor_indent_include_empty_line_is_head_gt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ml", get_expr_func("next", para_cursor_indent_include_empty_line_is_tail_gt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mh", get_expr_func("prev", para_cursor_indent_include_empty_line_is_tail_gt), {expr = true})

-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "m",
-- 	heads = {
-- 		{"j", get_expr_func("next", para_cursor_indent_include_empty_line_is_head_gt), {expr = true}},
-- 		{"k", get_expr_func("prev", para_cursor_indent_include_empty_line_is_head_gt), {expr = true}},
-- 	},
-- })
-- require("hydra").add({
-- 	mode = {"n", "x"},
-- 	body = "m",
-- 	heads = {
-- 		{"l", get_expr_func("next", para_cursor_indent_include_empty_line_is_tail_gt), {expr = true}},
-- 		{"h", get_expr_func("prev", para_cursor_indent_include_empty_line_is_tail_gt), {expr = true}},
-- 	},
-- })
