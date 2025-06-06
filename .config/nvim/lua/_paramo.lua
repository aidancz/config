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

map("{", "prev", require("para_nonempty_reverse").is_head_or_tail)
map("}", "next", require("para_nonempty_reverse").is_head_or_tail)

map("<a-d>", "next", require("para_nonempty").is_head)
map("<a-r>", "next", require("para_nonempty").is_tail)
map("<a-u>", "prev", require("para_nonempty").is_head)

map("<a-w>", "next", require("para_cursor_column").is_head)
map("<a-e>", "next", require("para_cursor_column").is_tail)
map("<a-b>", "prev", require("para_cursor_column").is_head)

local caret = function() vim.cmd("normal! ^") end
map(
	"<pageup>",
	"prev",
	function(pos)
		return
		require("para_cursor_indent").is_head_or_tail(
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
		require("para_cursor_indent").is_head_or_tail(
			pos,
			function(a, b)
				return true
			end
		)
	end,
	caret
)
