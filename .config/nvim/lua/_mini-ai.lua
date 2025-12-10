require("mini.deps").add({
	source = "nvim-mini/mini.ai",
})

-- # reuse some builtin textobjects

-- vim.keymap.set("o", "o", "a")
-- does not work since later config.mappings.around will override this

vim.keymap.set("o", "iu", "iw")
vim.keymap.set("o", "ou", "aw")

vim.keymap.set("o", "ir", "iW")
vim.keymap.set("o", "or", "aW")

vim.keymap.set("o", "i<cr>", "ip")
vim.keymap.set("o", "o<cr>", "ap")

-- # redefine require("mini.ai").select_textobject to work with virtualedit_all.lua

local select_textobject = require("mini.ai").select_textobject
require("mini.ai").select_textobject = function(ai_type, id, opts)
	select_textobject(ai_type, id, opts)
	vim.o.virtualedit = "onemore"
end
-- https://github.com/nvim-mini/mini.nvim/issues/1359

-- # require("paramo").gen_ai_spec

require("paramo").gen_ai_spec = function(para)
	return
	function(ai_type)
		local is_head = para.is_head
		local is_tail = para.is_tail

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
	end
end

-- # setup

-- ## config

local config =
{
	silent = true,
	custom_textobjects = {
		a = false,
		f = false,
	},
	mappings = {
		inside = "i",
		around = "o",

		inside_next = "in",
		inside_last = "ib",
		around_next = "on",
		around_last = "ob",

		goto_right = "g]",
		goto_left  = "g[",
	},
	n_lines = 1024,
	search_method = "cover_or_next",
}

-- ## (goto_left (next prev)) (goto_right (next prev))

-- https://github.com/nvim-mini/mini.nvim/issues/1093

require("mini.ai").make_ai_move_rhs_id = nil
require("mini.ai").make_ai_move_rhs = function(ask_id, side, search_method)
	return function()
		if ask_id then
			local ok, tobj_id = pcall(vim.fn.getcharstr)
			if not ok or tobj_id == "\27" then
				return
			end
			local tobj_esc = vim.fn.escape(tobj_id, "'\\")
			require("mini.ai").make_ai_move_rhs_id = tobj_esc
		end

		local opts = string.format(
			'{ n_times = %d, search_method = "%s" }',
			vim.v.count1,
			search_method
		)
		local cmd = string.format(
			'MiniAi.move_cursor("%s", "a", "%s", %s)',
			side,
			require("mini.ai").make_ai_move_rhs_id,
			opts
		)
		return "<Cmd>lua " .. cmd .. "<CR>"
	end
end

vim.keymap.set({"n", "x", "o"}, "gj", require("mini.ai").make_ai_move_rhs(true, "left",  "cover_or_next"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "gk", require("mini.ai").make_ai_move_rhs(true, "left",  "cover_or_prev"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "gl", require("mini.ai").make_ai_move_rhs(true, "right", "cover_or_next"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "gh", require("mini.ai").make_ai_move_rhs(true, "right", "cover_or_prev"), {expr = true})

require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "left", "cover_or_next")()]],
	from = "miniai_goto_head",
	name = "next",
	keys = {{"n", "x"}, "gj"},
})
require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "left", "cover_or_prev")()]],
	from = "miniai_goto_head",
	name = "prev",
	keys = {{"n", "x"}, "gk"},
})
require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "right", "cover_or_next")()]],
	from = "miniai_goto_tail",
	name = "next",
	keys = {{"n", "x"}, "gl"},
})
require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "right", "cover_or_prev")()]],
	from = "miniai_goto_tail",
	name = "prev",
	keys = {{"n", "x"}, "gh"},
})

-- ## extend

local extend = function(textobjects)
	config.custom_textobjects = vim.tbl_extend("force", config.custom_textobjects, textobjects)
end

-- ## textobjects: brackets

extend({
	["("] = { "%b()", "^.().*().$" },
	["["] = { "%b[]", "^.().*().$" },
	["{"] = { "%b{}", "^.().*().$" },
	["<"] = { "%b<>", "^.().*().$" },
	[")"] = { "%b()", "^.%s*().-()%s*.$" },
	["]"] = { "%b[]", "^.%s*().-()%s*.$" },
	["}"] = { "%b{}", "^.%s*().-()%s*.$" },
	[">"] = { "%b<>", "^.%s*().-()%s*.$" },
	i = {
		{
			"%b()",
			"%b[]",
			"%b{}",
			"%b<>",
		},
		"^.().*().$"
	},
	e = {
		{
			"%b()",
			"%b[]",
			"%b{}",
			"%b<>",
		},
		"^.%s*().-()%s*.$"
	},
})

vim.keymap.set(
	{"n", "x", "o"},
	"%",
	function()
		local id_brackets = "i"
		local goto_left = require("mini.ai").config.mappings.goto_left
		local goto_right = require("mini.ai").config.mappings.goto_right

		local row = vim.api.nvim_win_get_cursor(0)[1]
		local col = vim.api.nvim_win_get_cursor(0)[2] + 1
		local region = require("mini.ai").find_textobject("a", id_brackets, {search_method = "cover_or_next"})
		if
			row < region.from.line or (row == region.from.line and col < region.from.col)
			or
			row == region.to.line and col == region.to.col
		then
			return goto_left .. id_brackets
		else
			return goto_right .. id_brackets
		end
	end,
	{
		expr = true,
		remap = true,
	}
)

-- ## textobjects: quotes

extend({
	-- https://github.com/nvim-mini/mini.nvim/issues/1281
	-- 金铁击石全无力 大圣天蓬遭虎欺 枪刀戟剑浑不避 石猴似你不似你
	["'"] = { "%b''", "^.().*().$" },
	['"'] = { '%b""', "^.().*().$" },
	["`"] = { "%b``", "^.().*().$" },
	o = {
		{
			"%b''",
			'%b""',
			"%b``",
		},
		"^.().*().$"
	},
	w = {
		{
			"%'.-%'",
			'%".-%"',
			"%`.-%`",
		},
		"^.().*().$"
	},
})

-- ## textobjects: number

extend({
	x = require("mini.extra").gen_ai_spec.number(),
})

-- ## textobjects: line

extend({
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
})

-- ## textobjects: previously changed

extend({
	c = function(ai_type)
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
})

-- ## textobjects: indent

extend({
	m = function(ai_type)
		if ai_type == "i" then
			return require("paramo").gen_ai_spec(require("para_cursor_indent"))()
		else
			return require("paramo").gen_ai_spec(require("para_cursor_indent_include_empty_line"))()
		end
	end,
})

-- ## textobjects: ondent

extend({
	v = function(ai_type)
		if ai_type == "i" then
			return require("paramo").gen_ai_spec(require("para_cursor_ondent"))()
		else
			return require("paramo").gen_ai_spec(require("para_cursor_ondent_include_empty_line"))()
		end
	end,
})

-- ## textobjects: first_nonblank_char

extend({
	["^"] = require("paramo").gen_ai_spec(require("para_first_nonblank_char")),
})

-- ## textobjects: markdown fenced code block

extend({
	["`"] = function(ai_type)
	-- markdown fenced code block
		local lnum_3backticks_prev = vim.fn.search("```", "ncWb")
		local lnum_3backticks_next = vim.fn.search("```", "ncW")
		if
			lnum_3backticks_prev == 0
			or
			lnum_3backticks_next == 0
			or
			lnum_3backticks_next - lnum_3backticks_prev == 0
		then
			return
		end
		if ai_type == "i" then
			lnum_3backticks_prev = lnum_3backticks_prev + 1
			lnum_3backticks_next = lnum_3backticks_next - 1
		end
		return {
			from = {
				line = lnum_3backticks_prev,
				col = 1,
			},
			to = {
				line = lnum_3backticks_next,
				col = 1,
			},
			vis_mode = "V",
		}
	end,
})

-- ## textobjects_remap: line with eol

extend({
	["0"] = function(ai_type)
		return {
			from = {
				line = vim.fn.line("."),
				col = 1,
			},
			to = {
				line = vim.fn.line("."),
				col = string.len(vim.fn.getline(".")),
			},
			vis_mode = "V",
		}
	end,
})

vim.keymap.set({"x", "o"}, ".", "i0", {remap = true})

-- ## textobjects_remap: buffer

extend({
	["1"] = function(ai_type)
	-- i want to use <plug>(miniai_buffer) here, but only single char is allowed
	-- https://github.com/nvim-mini/mini.nvim/issues/754
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
})

vim.keymap.set({"x", "o"}, "a", "i1", {remap = true})

-- ## setup(config)

require("mini.ai").setup(config)
