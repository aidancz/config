-- require("mini.deps").add({
-- 	source = "aidancz/paramo.nvim",
-- })

require("paramo").get_expr_func = function(direction, is)
	return
	function()
		return
		require("paramo").expr({
			direction = direction,
			is = is,
		})
	end
end

-- # para_nonempty_reverse

vim.keymap.set({"n", "x", "o"}, "}", require("paramo").get_expr_func("next", require("para_nonempty_reverse").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "{", require("paramo").get_expr_func("prev", require("para_nonempty_reverse").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, ")", require("paramo").get_expr_func("next", require("para_nonempty_reverse").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "(", require("paramo").get_expr_func("prev", require("para_nonempty_reverse").is_tail), {expr = true})

-- # para_nonempty

vim.keymap.set({"n", "x", "o"}, "vj", require("paramo").get_expr_func("next", require("para_nonempty").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vk", require("paramo").get_expr_func("prev", require("para_nonempty").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vl", require("paramo").get_expr_func("next", require("para_nonempty").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vh", require("paramo").get_expr_func("prev", require("para_nonempty").is_tail), {expr = true})

require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_nonempty").is_head)()]],
	from = "para_nonempty_head",
	name = "next",
	keys = {{"n", "x"}, "vj"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_nonempty").is_head)()]],
	from = "para_nonempty_head",
	name = "prev",
	keys = {{"n", "x"}, "vk"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_nonempty").is_tail)()]],
	from = "para_nonempty_tail",
	name = "next",
	keys = {{"n", "x"}, "vl"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_nonempty").is_tail)()]],
	from = "para_nonempty_tail",
	name = "prev",
	keys = {{"n", "x"}, "vh"},
})

-- # para_cursor_column

vim.keymap.set({"n", "x", "o"}, "mf", require("paramo").get_expr_func("next", require("para_cursor_column").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "md", require("paramo").get_expr_func("prev", require("para_cursor_column").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mg", require("paramo").get_expr_func("next", require("para_cursor_column").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ms", require("paramo").get_expr_func("prev", require("para_cursor_column").is_tail), {expr = true})

require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_column").is_head)()]],
	from = "para_cursor_column_head",
	name = "next",
	keys = {{"n", "x"}, "mf"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_column").is_head)()]],
	from = "para_cursor_column_head",
	name = "prev",
	keys = {{"n", "x"}, "md"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_column").is_tail)()]],
	from = "para_cursor_column_tail",
	name = "next",
	keys = {{"n", "x"}, "mg"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_column").is_tail)()]],
	from = "para_cursor_column_tail",
	name = "prev",
	keys = {{"n", "x"}, "ms"},
})

-- # para_cursor_indent

vim.keymap.set({"n", "x", "o"}, "ef", require("paramo").get_expr_func("next", require("para_cursor_indent").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ed", require("paramo").get_expr_func("prev", require("para_cursor_indent").is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "eg", require("paramo").get_expr_func("next", require("para_cursor_indent").is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "es", require("paramo").get_expr_func("prev", require("para_cursor_indent").is_tail), {expr = true})

require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_indent").is_head)()]],
	from = "para_cursor_indent_head",
	name = "next",
	keys = {{"n", "x"}, "ef"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_indent").is_head)()]],
	from = "para_cursor_indent_head",
	name = "prev",
	keys = {{"n", "x"}, "ed"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_indent").is_tail)()]],
	from = "para_cursor_indent_tail",
	name = "next",
	keys = {{"n", "x"}, "eg"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_indent").is_tail)()]],
	from = "para_cursor_indent_tail",
	name = "prev",
	keys = {{"n", "x"}, "es"},
})

-- # para_cursor_indent_include_empty_line lt

require("para_cursor_indent_include_empty_line").is_head_lt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_head(
		pos,
		function(a, b)
			return a < b
		end
	)
end
require("para_cursor_indent_include_empty_line").is_tail_lt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_tail(
		pos,
		function(a, b)
			return a < b
		end
	)
end

vim.keymap.set({"n", "x", "o"}, "vf", require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_head_lt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vd", require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_head_lt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vg", require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_tail_lt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vs", require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_tail_lt), {expr = true})

require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_head_lt)()]],
	from = "para_cursor_indent_include_empty_line_head_lt",
	name = "next",
	keys = {{"n", "x"}, "vf"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_head_lt)()]],
	from = "para_cursor_indent_include_empty_line_head_lt",
	name = "prev",
	keys = {{"n", "x"}, "vd"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_tail_lt)()]],
	from = "para_cursor_indent_include_empty_line_tail_lt",
	name = "next",
	keys = {{"n", "x"}, "vg"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_tail_lt)()]],
	from = "para_cursor_indent_include_empty_line_tail_lt",
	name = "prev",
	keys = {{"n", "x"}, "vs"},
})

-- # para_cursor_indent_include_empty_line gt

require("para_cursor_indent_include_empty_line").is_head_gt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_head(
		pos,
		function(a, b)
			return a > b
		end
	)
end
require("para_cursor_indent_include_empty_line").is_tail_gt = function(pos)
	return
	require("para_cursor_indent_include_empty_line").is_tail(
		pos,
		function(a, b)
			return a > b
		end
	)
end

vim.keymap.set({"n", "x", "o"}, "mj", require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_head_gt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mk", require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_head_gt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ml", require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_tail_gt), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mh", require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_tail_gt), {expr = true})

require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_head_gt)()]],
	from = "para_cursor_indent_include_empty_line_head_gt",
	name = "next",
	keys = {{"n", "x"}, "mj"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_head_gt)()]],
	from = "para_cursor_indent_include_empty_line_head_gt",
	name = "prev",
	keys = {{"n", "x"}, "mk"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("next", require("para_cursor_indent_include_empty_line").is_tail_gt)()]],
	from = "para_cursor_indent_include_empty_line_tail_gt",
	name = "next",
	keys = {{"n", "x"}, "ml"},
})
require("luaexec").add({
	code = [[return require("paramo").get_expr_func("prev", require("para_cursor_indent_include_empty_line").is_tail_gt)()]],
	from = "para_cursor_indent_include_empty_line_tail_gt",
	name = "prev",
	keys = {{"n", "x"}, "mh"},
})
