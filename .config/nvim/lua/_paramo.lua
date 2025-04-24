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

map("<a-u>", "prev", require("para_nonempty").is_head)
map("<a-d>", "next", require("para_nonempty").is_tail)

map("<a-w>", "next", require("para_cursor_column").is_head)
map("<a-e>", "next", require("para_cursor_column").is_tail)
map("<a-b>", "prev", require("para_cursor_column").is_head)

local caret = function() vim.cmd("normal! ^") end
map("<pageup>",   "prev", require("para_cursor_indent").is_head_or_tail, caret)
map("<pagedown>", "next", require("para_cursor_indent").is_head_or_tail, caret)
map(
	"<",
	"next",
	function(pos)
		return
		require("para_cursor_indent").is_head(
			pos,
			function(a, b)
				return a < b
			end
		)
	end,
	caret
)
map(
	">",
	"next",
	function(pos)
		return
		require("para_cursor_indent").is_head(
			pos,
			function(a, b)
				return a > b
			end
		)
	end,
	caret
)
map(
	"(",
	"prev",
	function(pos)
		return
		require("para_cursor_indent").is_head(
			pos,
			function(a, b)
				return a < b
			end
		)
	end,
	caret
)
map(
	")",
	"prev",
	function(pos)
		return
		require("para_cursor_indent").is_head(
			pos,
			function(a, b)
				return a > b
			end
		)
	end,
	caret
)

-- require("modexec").add_mode({
-- 	name = "modexec",
-- 	chunks = {
-- 		{
-- 			code = [[require("modexec").set_current_mode("buffer")]],
-- 			gkey = {"n", "fs"},
-- 		},
-- 		{
-- 			code = [[require("modexec").set_current_mode("window")]],
-- 			gkey = {"n", "fw"},
-- 		},
-- 	},
-- })
