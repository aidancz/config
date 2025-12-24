require("mini.deps").add({
	source = "nvim-mini/mini.ai",
})

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
	function(ai_type, id, opts)
		local range = require("paramo").find_para(para)
		return {
			from = {
				line = range[1].lnum,
				col = 1,
			},
			to = {
				line = range[2].lnum,
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
		-- a = false,
		-- f = false,
	},
	mappings = {
		inside = "i",
		around = "u",

		inside_next = "in",
		inside_last = "ib",
		around_next = "un",
		around_last = "ub",

		goto_right = "<plug>(miniai_goto_right)",
		goto_left  = "<plug>(miniai_goto_left)",
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

vim.keymap.set({"n", "x", "o"}, "gj", require("mini.ai").make_ai_move_rhs(true, "left",  "next"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "gk", require("mini.ai").make_ai_move_rhs(true, "left",  "prev"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "gl", require("mini.ai").make_ai_move_rhs(true, "right", "next"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "gh", require("mini.ai").make_ai_move_rhs(true, "right", "prev"), {expr = true})

require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "left", "next")()]],
	from = "miniai_goto_head",
	name = "next",
	keys = {{"n", "x"}, "gj"},
})
require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "left", "prev")()]],
	from = "miniai_goto_head",
	name = "prev",
	keys = {{"n", "x"}, "gk"},
})
require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "right", "next")()]],
	from = "miniai_goto_tail",
	name = "next",
	keys = {{"n", "x"}, "gl"},
})
require("luaexec").add({
	code = [[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_is_repeat, "right", "prev")()]],
	from = "miniai_goto_tail",
	name = "prev",
	keys = {{"n", "x"}, "gh"},
})

-- ## extend

local extend = function(textobjects)
	config.custom_textobjects = vim.tbl_extend("force", config.custom_textobjects, textobjects)
end

-- ## extend_remap

--[[
mini.ai can only map textobject to i<char> and a<char>, cannot map textobject to <char>
we have to remap

e.g. map line textobject to dot:

extend({
	["0"] = function(ai_type)
	-- i want to use <plug>(miniai_line) here, but only single char is allowed
	-- https://github.com/nvim-mini/mini.nvim/issues/754
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

factor this process into a function: extend_remap
--]]

local gen_char =
	(
		function()
			local id = 0x2460
			return
				function()
					-- assert((id >= 0x2460) and (id <= 0x2473))
					local char = vim.fn.nr2char(id)
					id = id + 1
					return char
				end
		end
	)()

local extend_remap = function(key, spec)
	local char = gen_char()
	extend({[char] = spec})
	vim.keymap.set({"x", "o"}, key, config.mappings.inside .. char, {remap = true})
end

-- ## textobjects: mini.ai default

extend({
	-- [<not latin letters>] = function(ai_type) <i: inside separators, a: inside separators and right edge> end,
	-- :h MiniAi-builtin-textobjects, search "Default"
})

-- ## textobjects: word

extend({
	-- "\9\32" == "\t " == HT and SP == tab and space

	["l"] = { "()()" .. "%f[%l][%l]+" .. "()[\9\32]*()" }, -- lowercase letters
	["u"] = { "()()" .. "%f[%u][%u]+" .. "()[\9\32]*()" }, -- uppercase letters
	["d"] = { "()()" .. "%f[%d][%d]+" .. "()[\9\32]*()" }, -- digits
	["p"] = { "()()" .. "%f[%p][%p]+" .. "()[\9\32]*()" }, -- punctuation characters
	["s"] = { "%f[%s][%s]+" },                             -- space characters (HT LF VT FF CR SP)
	["z"] = { "[%z]+" },                                   -- NUL (cannot use %f[] due to how it works)
	["c"] = { "%f[\1-\8\14-\31\127][\1-\8\14-\31\127]+" }, -- control characters except {NUL HT LF VT FF CR}
	-- separate ascii into several groups

	["a"] = { "()()" .. "%f[%a][%a]+" .. "()[\9\32]*()" }, -- %a = %l + %u
	["w"] = { "()()" .. "%f[%w][%w]+" .. "()[\9\32]*()" }, -- %w = %l + %u + %d
	["g"] = { "()()" .. "%f[%g][%g]+" .. "()[\9\32]*()" }, -- %g = %l + %u + %d + %p

	[" "] = { "()()" .. "%f[%w_][%w_]+" .. "()[\9\32]*()" },

	-- ["x"] = { "()()" .. "%f[%x][%x]+" .. "()[\9\32]*()" }, -- %x = {abcdefABCDEF} + %d
	["x"] = require("mini.extra").gen_ai_spec.number(),
})

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
	y = {
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
	e = {
		{
			"%b''",
			'%b""',
			"%b``",
		},
		"^.().*().$"
	},
	t = {
		{
			"%'.-%'",
			'%".-%"',
			"%`.-%`",
		},
		"^.().*().$"
	},
})

-- ## textobjects: previously changed

extend({
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
})

-- ## textobjects: line

extend_remap(
	".",
	function(ai_type)
		return {
			from = {
				line = vim.fn.line("."),
				col = 1,
			},
			to = {
				line = vim.fn.line("."),
				col = vim.fn.col("$"),
			},
			vis_mode = "V",
		}
	end
)

extend({
	["."] = function(ai_type)
		local lnum_cursor = vim.fn.line(".")
		local line_cursor = vim.fn.getline(".")

		local col_start = 1
		local col_first_nonblank = string.find(line_cursor, "%S")
		local col_end = string.len(line_cursor)

		if col_end == 0 then return end
		-- empty line
		if col_first_nonblank == nil and ai_type == "i" then return end
		-- only whitespace

		return {
			from = {
				line = lnum_cursor,
				col = (ai_type == "i") and col_first_nonblank or col_start
			},
			to = {
				line = lnum_cursor,
				col = col_end,
			},
			vis_mode = "v",
		}
	end,
})

-- ## textobjects: para emptiness_row {empty = false}

extend({
	["\r"] = require("paramo").gen_ai_spec(require("para/emptiness_row")({empty = false})),
})

-- ## textobjects: para indent {indent_empty = "inherit_consistent_nonzero", indent_block = "special"}

extend({
	m = function(ai_type)
		return require("paramo").gen_ai_spec(
			require("para/indent")({
				indent_empty = "inherit_consistent_nonzero",
				indent_block = "special",
			})
		)()
	end,
})

-- ## textobjects: para indent {indent_empty = "inherit_consistent_nonzero", indent_block = "general"}

extend({
	v = function(ai_type)
		return require("paramo").gen_ai_spec(
			require("para/indent")({
				indent_empty = "inherit_consistent_nonzero",
				indent_block = "general",
			})
		)()
	end,
})

-- ## textobjects: first_nonblank_char

extend({
	-- ["^"] = require("paramo").gen_ai_spec(require("para_first_nonblank_char")),
})

-- ## textobjects: buffer

extend_remap(
	",",
	function(ai_type)
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
	end
)

-- ## textobjects: (markdown) fenced code block

extend({
	["C"] = {
		"```.-\n().-()```\n",
	},
})

-- ## textobjects: test

extend({
})

-- ## setup(config)

require("mini.ai").setup(config)
