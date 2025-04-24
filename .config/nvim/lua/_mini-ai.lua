require("mini.deps").add({
	source = "echasnovski/mini.ai",
})

require("mini.ai").setup({
	silent = true,
	custom_textobjects = {

		["("] = { "%b()", "^.().*().$" },
		["["] = { "%b[]", "^.().*().$" },
		["{"] = { "%b{}", "^.().*().$" },
		["<"] = { "%b<>", "^.().*().$" },
		[")"] = { "%b()", "^.%s*().-()%s*.$" },
		["]"] = { "%b[]", "^.%s*().-()%s*.$" },
		["}"] = { "%b{}", "^.%s*().-()%s*.$" },
		[">"] = { "%b<>", "^.%s*().-()%s*.$" },
		b = {
			{
				"%b()",
				"%b[]",
				"%b{}",
				"%b<>",
			},
			"^.().*().$"
		},

		-- https://github.com/echasnovski/mini.nvim/issues/1281
		["'"] = { "%b''", "^.().*().$" },
		['"'] = { '%b""', "^.().*().$" },
		["`"] = { "%b``", "^.().*().$" },
		q = {
			{
				"%b''",
				'%b""',
				"%b``",
			},
			"^.().*().$"
		},
		-- 金铁击石全无力 大圣天蓬遭虎欺 枪刀戟剑浑不避 石猴似你不似你

		Q = {
			{
				"%'.-%'",
				'%".-%"',
				"%`.-%`",
			},
			"^.().*().$"
		},

		x = require("mini.extra").gen_ai_spec.number(),

		l = function(ai_type)
			local lnum_cursor = vim.fn.line(".")
			local line_cursor = vim.fn.getline(".")

			local col_start = 1
			local col_first_nonblank = string.find(line_cursor, "%S")
			local col_end = string.len(line_cursor)

			local from = {
				line = lnum_cursor,
				-- col = ?,
			}
			local to = {
				line = lnum_cursor,
				col = col_end,
			}
			if ai_type == "i" then
				from.col = col_first_nonblank
			else
				from.col = col_start
			end

			if col_end == 0 then
			-- empty line
				to = nil
			end
			if col_first_nonblank == nil and ai_type == "i" then
			-- only whitespace
				to = nil
			end

			return {
				from = from,
				to = to,
				vis_mode = "v",
			}
		end,

		r = function(ai_type)
			return {
				from = {
					line = vim.api.nvim_buf_get_mark(0, "[")[1],
					col  = vim.api.nvim_buf_get_mark(0, "[")[2] + 1,
				},
				to = {
					line = vim.api.nvim_buf_get_mark(0, "]")[1],
					col  = vim.api.nvim_buf_get_mark(0, "]")[2] + 1,
				},
				vis_mode = ai_type == "i" and "v" or "V",
			}
		end,

		i = function(ai_type)
			local is_head
			local is_tail
			if ai_type == "i" then
				is_head = require("para_cursor_indent").is_head
				is_tail = require("para_cursor_indent").is_tail
			else
				is_head = require("para_cursor_indent_include_empty_line").is_head
				is_tail = require("para_cursor_indent_include_empty_line").is_tail
			end

			local pos_head
			local pos_tail
			local pos_cursor = require("virtcol").get_cursor()
			if is_head(pos_cursor) then
				pos_head = pos_cursor
			else
				pos_head = require("paramo").prev_pos(pos_cursor, is_head)
			end
			if is_tail(pos_cursor) then
				pos_tail = pos_cursor
			else
				pos_tail = require("paramo").next_pos(pos_cursor, is_tail)
			end

			return {
				from = {
					line = pos_head.lnum,
					col = 1,
				},
				to = {
					line = pos_tail.lnum,
					col = 1,
				},
				vis_mode = "V",
			}
		end,

		o = function(ai_type)
			local is_head
			local is_tail
			if ai_type == "i" then
				is_head = require("para_cursor_ondent").is_head
				is_tail = require("para_cursor_ondent").is_tail
			else
				is_head = require("para_cursor_ondent_include_empty_line").is_head
				is_tail = require("para_cursor_ondent_include_empty_line").is_tail
			end

			local pos_head
			local pos_tail
			local pos_cursor = require("virtcol").get_cursor()
			if is_head(pos_cursor) then
				pos_head = pos_cursor
			else
				pos_head = require("paramo").prev_pos(pos_cursor, is_head)
			end
			if is_tail(pos_cursor) then
				pos_tail = pos_cursor
			else
				pos_tail = require("paramo").next_pos(pos_cursor, is_tail)
			end

			return {
				from = {
					line = pos_head.lnum,
					col = 1,
				},
				to = {
					line = pos_tail.lnum,
					col = 1,
				},
				vis_mode = "V",
			}
		end,

		C = function(ai_type)
			local is_head
			local is_tail
			is_head = require("para_first_nonblank_char").is_head
			is_tail = require("para_first_nonblank_char").is_tail

			local pos_head
			local pos_tail
			local pos_cursor = require("virtcol").get_cursor()
			if is_head(pos_cursor) then
				pos_head = pos_cursor
			else
				pos_head = require("paramo").prev_pos(pos_cursor, is_head)
			end
			if is_tail(pos_cursor) then
				pos_tail = pos_cursor
			else
				pos_tail = require("paramo").next_pos(pos_cursor, is_tail)
			end

			return {
				from = {
					line = pos_head.lnum,
					col = 1,
				},
				to = {
					line = pos_tail.lnum,
					col = 1,
				},
				vis_mode = "V",
			}
		end,

		e = function(ai_type)
		-- entire buffer
			return {
				from = {
					line = 1,
					col = 1,
				},
				to = {
					line = vim.fn.line("$"),
					col = vim.fn.col({vim.fn.line("$"), "$"}),
				},
				vis_mode = "V",
			}
		end,

		c = function(ai_type, id, opts)
			local f = require("mini.ai").gen_spec.treesitter({
				i = "@block.inner",
				a = "@block.outer",
			})
			local o = f(ai_type, id, opts)
			for _, i in pairs(o) do
				i.vis_mode = "V"
			end
			return o
		end,

	},
	mappings = {
		around_next = "an",
		inside_next = "in",
		around_last = "aN",
		inside_last = "iN",

		goto_left  = "g[",
		goto_right = "g]",
	},
	n_lines = 1024,
	search_method = "cover_or_next",
})



vim.keymap.set(
	{"n", "x", "o"},
	"%",
	function()
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local col = vim.api.nvim_win_get_cursor(0)[2] + 1
		local region = require("mini.ai").find_textobject("a", "b", {search_method = "cover_or_next"})
		if
			row < region.from.line or (row == region.from.line and col < region.from.col)
			or
			row == region.to.line and col == region.to.col
		then
			return "g[b"
		else
			return "g]b"
		end
	end,
	{
		expr = true,
		remap = true,
	}
)
