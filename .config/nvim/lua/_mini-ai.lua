vim.pack.add({
	"https://github.com/nvim-mini/mini.ai",
})
vim.opt.runtimepath:prepend("~/sync_git/paramo.nvim")

-- # require("paramo").gen_ai_spec

require("paramo").gen_para_with_empty_heads = function(para)
	local V = require("virtcol")
	local para_0 = require("para/emptiness_row")({empty = true})
	local para_1 = require("para/emptiness_row")({empty = false})
	local is_empty = function(pos)
		return vim.fn.getline(pos.lnum) == ""
	end
	local is_head_nonempty = function(pos) return para.is_head(pos) and (not is_empty(pos)) end
	local is_tail_nonempty = function(pos) return para.is_tail(pos) and (not is_empty(pos)) end
	return {
		is_head = function(pos)
			return
				(
					is_head_nonempty(pos)
					and
					(
						vim.tbl_isempty(V.prev_pos(pos))
						or
						not is_empty(V.prev_pos(pos))
					)
				)
				or
				(
					para_0.is_head(pos)
					and
					is_head_nonempty(require("paramo").next_pos(pos, para_1.is_head))
				)
		end,
		is_tail = is_tail_nonempty,
	}
end

require("paramo").gen_para_with_empty_tails = function(para)
	local V = require("virtcol")
	local para_0 = require("para/emptiness_row")({empty = true})
	local para_1 = require("para/emptiness_row")({empty = false})
	local is_empty = function(pos)
		return vim.fn.getline(pos.lnum) == ""
	end
	local is_head_nonempty = function(pos) return para.is_head(pos) and (not is_empty(pos)) end
	local is_tail_nonempty = function(pos) return para.is_tail(pos) and (not is_empty(pos)) end
	return {
		is_head = is_head_nonempty,
		is_tail = function(pos)
			return
				(
					is_tail_nonempty(pos)
					and
					(
						vim.tbl_isempty(V.next_pos(pos))
						or
						not is_empty(V.next_pos(pos))
					)
				)
				or
				(
					para_0.is_tail(pos)
					and
					is_tail_nonempty(require("paramo").prev_pos(pos, para_1.is_tail))
				)
		end,
	}
end

require("paramo").gen_ai_spec = function(para)
	local para_i = para
	local para_a = require("paramo").gen_para_with_empty_heads(para)
	-- local para_a = require("paramo").gen_para_with_empty_tails(para)

	return
	function(ai_type, id, opts)
		local range
		if ai_type == "i" then
			range = require("paramo").find_para(para_i, opts)
		else
			range = require("paramo").find_para(para_a, opts)
		end
		if vim.tbl_isempty(range[1]) or vim.tbl_isempty(range[2]) then return end

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

-- ## define extend

local extend = function(textobjects)
	config.custom_textobjects = vim.tbl_extend("force", config.custom_textobjects, textobjects)
end

-- ## define extend_remap

--[[
mini.ai can only map textobject to i<char> and a<char>, cannot map textobject to <char>
we have to remap

e.g. map line textobject to dot:

extend({
	["0"] = function(ai_type, id, opts)
	-- i want to use <plug>(miniai_line) here, but only single char is allowed
	-- https://github.com/nvim-mini/mini.nvim/issues/754
		return {
			from = {
				line = vim.fn.line("."),
				col = 1,
			},
			to = {
				line = vim.fn.line("."),
				col = 1,
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

-- ## extend(mini.ai default)

extend({
	-- [<not latin letters>] = function(ai_type, id, opts) <i: inside separators, a: inside separators and right edge> end,
	-- :h MiniAi-builtin-textobjects, search "Default"
})

-- ## extend(word)

local gen_spec_word = function(chars)
-- https://github.com/nvim-mini/mini.nvim/discussions/2251
	-- return {
	-- 	{
	-- 		"%f[%w \t][%w]+",
	-- 		"()%f[ \t][ \t]*()%f[%w][%w]+()()",
	-- 	},
	-- }
	return {
		{
			"%f[" .. chars .. " \t][" .. chars .. "]+",
			"()%f[ \t][ \t]*()%f[" .. chars .. "][" .. chars .. "]+()()",
		},
	}
end

extend({
	["l"] = gen_spec_word("%l"), -- lowercase letters
	["u"] = gen_spec_word("%u"), -- uppercase letters
	["d"] = gen_spec_word("%d"), -- digits
	["p"] = gen_spec_word("%p"), -- punctuation characters
	["s"] = { "%f[%s]%s+" }, -- space characters (HT LF VT FF CR SP)
	["z"] = { "%z" }, -- NUL (cannot use %f[] due to how it works)
	["c"] = { "%f[\1-\8\14-\31\127][\1-\8\14-\31\127]+" }, -- control characters except {NUL HT LF VT FF CR}
	-- separate ascii into several groups

	["a"] = gen_spec_word("%a"),  -- %a  = %l + %u
	["w"] = gen_spec_word("%w"),  -- %w  = %l + %u + %d
	[" "] = gen_spec_word("%w_"), -- %w_ = %l + %u + %d + _
	["g"] = gen_spec_word("%g"),  -- %g  = %l + %u + %d + %p

	-- ["x"] = gen_spec_word("%x"), -- %x = {abcdefABCDEF} + %d
	["x"] = require("mini.extra").gen_ai_spec.number(),
})

-- ## extend(brackets)

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
		"^.().*().$",
	},
	y = {
		{
			"%b()",
			"%b[]",
			"%b{}",
			"%b<>",
		},
		"^.%s*().-()%s*.$",
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

-- ## extend(quotes)

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
		"^.().*().$",
	},
	t = {
		{
			"%'.-%'",
			'%".-%"',
			"%`.-%`",
		},
		"^.().*().$",
	},
})

-- ## extend(inline)

extend({
	["."] = function(ai_type, id, opts)
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
				col = (ai_type == "i") and col_first_nonblank or col_start,
			},
			to = {
				line = lnum_cursor,
				col = col_end,
			},
			vis_mode = "v",
		}
	end,
})

-- ## extend(previously changed)

extend({
	r = function(ai_type, id, opts)
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

-- ## extend(user prompt)

extend({
	["?"] = require("mini.ai").gen_spec.user_prompt(),
})

-- ## extend_remap(line)

extend_remap(
	".",
	function(ai_type, id, opts)
		return {
			from = {
				line = vim.fn.line("."),
				col = 1,
			},
			to = {
				line = vim.fn.line("."),
				col = 1,
			},
			vis_mode = "V",
		}
	end
)

-- ## extend(para paragraph)

extend({
	["\r"] = require("paramo").gen_ai_spec(
		require("para/emptiness_row")({empty = false})
	),
})

-- ## extend(para indent)

extend({
	["\t"] = require("paramo").gen_ai_spec(
		require("para/indent")({
			indent_empty = "intact",
			type = "==",
		})
	),
})

-- ## extend(para indent)

extend({
	v = require("paramo").gen_ai_spec(
		require("para/indent")({
			indent_empty = "max",
			type = ">=.",
		})
	),
})

-- ## extend(para indent)

extend({
	m = require("paramo").gen_ai_spec(
		require("para/indent")({
			indent_empty = "max_beyond_cursor",
			type = ">=.",
		})
	),
})

-- ## extend(para char1)

extend({
	["^"] = require("paramo").gen_ai_spec(
		require("para/char1")()
	),
})

-- ## extend_remap(buffer)

extend_remap(
	",",
	function(ai_type, id, opts)
		return {
			from = {
				line = 1,
				col = 1,
			},
			to = {
				line = vim.fn.line("$"),
				col = 1,
			},
			vis_mode = "V",
		}
	end
)

-- ## extend(argument)

extend({
	j = require("mini.ai").gen_spec.argument(),
	-- TODO: implement my own
})

-- ## extend(function call)

extend({
	f = require("mini.ai").gen_spec.function_call(),
})

-- ## extend(markdown fenced code block)

extend({
	["C"] = {
		"```.-\n().-()```\n",
	},
})

-- ## extend(sgml tag)

extend({
	["T"] = {
		"<(%w-)%f[^<%w][^<>]->.-</%1>",
		"^<.->().*()</[^/]->$",
	},
})

-- ## extend(test)

extend({
})

-- ## setup(config)

require("mini.ai").setup(config)

-- # require("mini.ai").make_ai_move_rhs

-- https://github.com/nvim-mini/mini.nvim/issues/1093

require("mini.ai").make_ai_move_rhs_id = nil
require("mini.ai").make_ai_move_rhs = function(ask_id, side, search_method)
	return function()
		if ask_id then
			local ok, tobj_id = pcall(vim.fn.getcharstr)
			if not ok or tobj_id == "\27" then
			-- ascii 27 is ESC
				return
			end
			require("mini.ai").make_ai_move_rhs_id = vim.inspect(tobj_id)
		end

		local opts = string.format(
			[[{n_times = %s, search_method = %s}]],
			vim.inspect(vim.v.count1),
			vim.inspect(search_method)
		)
		local cmd = string.format(
			[[require("mini.ai").move_cursor(%s, "i", %s, %s)]],
			vim.inspect(side),
			require("mini.ai").make_ai_move_rhs_id,
			opts
		)
		return "<cmd>lua " .. cmd .. "<cr>"
	end
end

vim.keymap.set({"n", "x", "o"}, "<cr>j", require("mini.ai").make_ai_move_rhs(true, "left",  "next"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<cr>k", require("mini.ai").make_ai_move_rhs(true, "left",  "prev"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<cr>l", require("mini.ai").make_ai_move_rhs(true, "right", "next"), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<cr>h", require("mini.ai").make_ai_move_rhs(true, "right", "prev"), {expr = true})

require("luaexec").add({
	code =
[[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_cache.is_repeat, "left",  "next")()]],
	from = "miniai_goto_head",
	name = "next",
	keys = {{"n", "x"}, "<cr>j"},
})
require("luaexec").add({
	code =
[[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_cache.is_repeat, "left",  "prev")()]],
	from = "miniai_goto_head",
	name = "prev",
	keys = {{"n", "x"}, "<cr>k"},
})
require("luaexec").add({
	code =
[[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_cache.is_repeat, "right", "next")()]],
	from = "miniai_goto_tail",
	name = "next",
	keys = {{"n", "x"}, "<cr>l"},
})
require("luaexec").add({
	code =
[[return require("mini.ai").make_ai_move_rhs(not require("luaexec").np_cache.is_repeat, "right", "prev")()]],
	from = "miniai_goto_tail",
	name = "prev",
	keys = {{"n", "x"}, "<cr>h"},
})
