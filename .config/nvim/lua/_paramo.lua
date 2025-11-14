-- require("mini.deps").add({
-- 	source = "aidancz/paramo.nvim",
-- 	depends = {
-- 		{
-- 			source = "aidancz/virtcol.nvim",
-- 		},
-- 	},
-- })

local map = function(key, direction, is, hook)
	vim.keymap.set(
		{"n", "x", "o"},
		key,
		function()
			return
			require("paramo").expr({
				direction = direction,
				is = is,
				hook = hook,
			})
		end,
		{expr = true}
	)
end

map("{", "prev", require("para_nonempty_reverse").is_head)
map("}", "next", require("para_nonempty_reverse").is_head)
map("(", "prev", require("para_nonempty_reverse").is_tail)
map(")", "next", require("para_nonempty_reverse").is_tail)

map("vk", "prev", require("para_nonempty").is_head)
map("vj", "next", require("para_nonempty").is_head)
map("vh", "prev", require("para_nonempty").is_tail)
map("vl", "next", require("para_nonempty").is_tail)

map("ms", "next", require("para_cursor_column").is_head)
map("mo", "prev", require("para_cursor_column").is_head)
map("mx", "next", require("para_cursor_column").is_tail)

local caret = function() vim.cmd("normal! ^") end
map(
	"<pageup>",
	"prev",
	function(pos)
		return
		require("para_cursor_indent").is_head(
			pos,
			function(a, b)
				return true
			end
		)
	end,
	caret
)
map(
	"<pagedown>",
	"next",
	function(pos)
		return
		require("para_cursor_indent").is_head(
			pos,
			function(a, b)
				return true
			end
		)
	end,
	caret
)
