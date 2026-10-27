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

do return end

-- # para emptiness_row {empty = true}

local para = require("para/emptiness_row")({empty = true})

vim.keymap.set({"n", "x", "o"}, "}", require("paramo").get_expr_func("next", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, "{", require("paramo").get_expr_func("prev", para.is_head), {expr = true})
vim.keymap.set({"n", "x", "o"}, ")", require("paramo").get_expr_func("next", para.is_tail), {expr = true})
vim.keymap.set({"n", "x", "o"}, "(", require("paramo").get_expr_func("prev", para.is_tail), {expr = true})
