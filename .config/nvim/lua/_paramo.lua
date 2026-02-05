vim.opt.runtimepath:prepend("~/sync_git/paramo.nvim")

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

-- # para emptiness_row {empty = true}

local para = require("para/emptiness_row")({empty = true})

vim.keymap.set({"n", "x", "o"}, "}", require("paramo").get_expr_func("next", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "{", require("paramo").get_expr_func("prev", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, ")", require("paramo").get_expr_func("next", para.is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "(", require("paramo").get_expr_func("prev", para.is_tail), {expr = true})

do return end

-- # para emptiness_row {empty = false}

local para = require("para/emptiness_row")({empty = false})

vim.keymap.set({"n", "x", "o"}, "vj", require("paramo").get_expr_func("next", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vk", require("paramo").get_expr_func("prev", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vl", require("paramo").get_expr_func("next", para.is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vh", require("paramo").get_expr_func("prev", para.is_tail), {expr = true})

-- # para emptiness_virtcol {empty = false}

local para = require("para/emptiness_virtcol")({empty = false})

vim.keymap.set({"n", "x", "o"}, "mf", require("paramo").get_expr_func("next", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "md", require("paramo").get_expr_func("prev", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mg", require("paramo").get_expr_func("next", para.is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ms", require("paramo").get_expr_func("prev", para.is_tail), {expr = true})

-- # para indent {indent_empty = "inherit_consistent_nonzero", indent_block = "special"}

local para = require("para/indent")({
	indent_empty = "inherit_consistent_nonzero",
	indent_block = "special",
})

vim.keymap.set({"n", "x", "o"}, "mj", require("paramo").get_expr_func("next", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mk", require("paramo").get_expr_func("prev", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "ml", require("paramo").get_expr_func("next", para.is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "mh", require("paramo").get_expr_func("prev", para.is_tail), {expr = true})

-- # para indent {indent_empty = "inherit_consistent_nonzero", indent_block = "general"}

local para = require("para/indent")({
	indent_empty = "inherit_consistent_nonzero",
	indent_block = "general",
})

vim.keymap.set({"n", "x", "o"}, "vf", require("paramo").get_expr_func("next", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vd", require("paramo").get_expr_func("prev", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vg", require("paramo").get_expr_func("next", para.is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "vs", require("paramo").get_expr_func("prev", para.is_tail), {expr = true})
