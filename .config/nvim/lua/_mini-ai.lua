vim.pack.add({
	"https://github.com/nvim-mini/mini.ai",
})

-- vim.opt.runtimepath:prepend("/home/aidan/Downloads/mini.ai")

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

require("paramo").gen_ai_spec = function(para, skip_para_a)
	local V = require("virtcol")

	local para_i = para

	local para_a
	if skip_para_a then
		para_a = para
	else
		-- para_a = require("paramo").gen_para_with_empty_heads(para)
		para_a = require("paramo").gen_para_with_empty_tails(para)
	end

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
				col = V.virtcol2col(range[1].lnum, range[1].virtcol),
			},
			to = {
				line = range[2].lnum,
				col = V.virtcol2col(range[2].lnum, range[2].virtcol),
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

		goto_right = "",
		goto_left  = "",
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

-- ## extend(cursor_i)

extend_remap(
	"d",
	function(ai_type, id, opts)
		return {
			from = {
				line = vim.fn.line("."),
				col = vim.fn.col("."),
			},
			to = nil, -- empty region
			vis_mode = "v",
		}
	end
)

-- ## extend(cursor_a)

extend_remap(
	"f",
	function(ai_type, id, opts)
		return {
			from = {
				line = vim.fn.line("."),
				col = vim.fn.col(".") + 1,
			},
			to = nil, -- empty region
			vis_mode = "v",
		}
	end
)

-- ## extend(mini.ai default)

extend({
	-- [<%p or %d, punctuation or digit>] = function(ai_type, id, opts)
	-- 	<i: inside separators, a: inside separators and right edge>
	-- end,
	-- :h MiniAi-builtin-textobjects, search "Default"
})

-- ## extend(word)

local gen_spec_word_with_leading_whitespace = function(chars)
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

local gen_spec_word_with_trailing_whitespace = function(chars)
	-- return {
	-- 	"()()%f[%w][%w]+()[ \t]*()",
	-- }
	return {
		"()()%f[" .. chars .. "][" .. chars .. "]+()[ \t]*()",
	}
end

-- local gen_spec_word = gen_spec_word_with_leading_whitespace
local gen_spec_word = gen_spec_word_with_trailing_whitespace

extend({
	["l"] = gen_spec_word("%l"), -- lowercase letters
	["u"] = gen_spec_word("%u"), -- uppercase letters
	["d"] = gen_spec_word("%d"), -- digits
	["p"] = gen_spec_word("%p"), -- punctuation characters
	["s"] = { "%f[%s][%s]+" }, -- space characters (HT LF VT FF CR SP)
	["z"] = { "%z" }, -- NUL (cannot use %f[] due to how it works)
	["c"] = { "%f[\1-\8\14-\31\127][\1-\8\14-\31\127]+" }, -- control characters except {NUL HT LF VT FF CR}
	-- separate ascii into several groups

	["a"] = gen_spec_word("%a"),     -- %a     = %l + %u
	["w"] = gen_spec_word("%w"),     -- %w     = %l + %u + %d
	["o"] = gen_spec_word("%w%_%-"), -- %w%_%- = %l + %u + %d + %_ + %- (%- matches a literal hyphen, because - normally defines a range inside a character class)
	["g"] = gen_spec_word("%g"),     -- %g     = %l + %u + %d + %p

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

-- vim.keymap.set(
-- 	{"n", "x", "o"},
-- 	"%",
-- 	function()
-- 		local id_brackets = "i"
-- 		local goto_left = require("mini.ai").config.mappings.goto_left
-- 		local goto_right = require("mini.ai").config.mappings.goto_right
--
-- 		local row = vim.api.nvim_win_get_cursor(0)[1]
-- 		local col = vim.api.nvim_win_get_cursor(0)[2] + 1
-- 		local region = require("mini.ai").find_textobject("a", id_brackets, {search_method = "cover_or_next"})
-- 		if
-- 			row < region.from.line or (row == region.from.line and col < region.from.col)
-- 			or
-- 			row == region.to.line and col == region.to.col
-- 		then
-- 			return goto_left .. id_brackets
-- 		else
-- 			return goto_right .. id_brackets
-- 		end
-- 	end,
-- 	{
-- 		expr = true,
-- 		remap = true,
-- 	}
-- )

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

-- ## extend(para emptiness_row 0)

extend({
	[" "] = require("paramo").gen_ai_spec(
		require("para/emptiness_row")({empty = true}), "skip_para_a"
	),
})

-- ## extend(para emptiness_row 1)

extend({
	["\r"] = require("paramo").gen_ai_spec(
		require("para/emptiness_row")({empty = false})
	),
})

-- ## extend(para emptiness_virtcol 1)

extend({
	["h"] = require("paramo").gen_ai_spec(
		require("para/emptiness_virtcol")({empty = false})
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
	j = require("mini.ai").gen_spec.argument({
		separator = "%s*,%s*",
	}),
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

-- # require("mini.ai").find_textobject

-- require("mini.ai").find_textobject is required by require("mini.ai").move_cursor
-- require("mini.ai").find_textobject("a", "w", {search_method = "next"})
-- 	-- simulate w, cannot simulate e
-- require("mini.ai").find_textobject("a", "w", {search_method = "prev"})
-- 	-- simulate ge, cannot simulate b
-- so we add new search_method to simulate e and b

local H = {}
H.get_config = function(config)
	return vim.tbl_deep_extend("force", MiniAi.config, vim.b.miniai_config or {}, config or {})
end
H.get_default_opts = function()
	local config = H.get_config()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	return {
		n_lines = config.n_lines,
		n_times = vim.v.count1,
		-- Empty region at cursor position
		reference_region = { from = { line = cur_pos[1], col = cur_pos[2] + 1 } },
		search_method = config.search_method,
	}
end

local convert_pos = function(pos_miniai)
	local pos_vimpos = vim.pos(
		0,
		pos_miniai.line - 1,
		pos_miniai.col - 1
	)
	return pos_vimpos
end
local get_pos_cursor = function()
	return vim.pos.cursor(0, vim.api.nvim_win_get_cursor(0))
end

local find_textobject = require("mini.ai").find_textobject
require("mini.ai").find_textobject = function(ai_type, id, opts)
	opts = vim.tbl_deep_extend("force", H.get_default_opts(), opts or {})
	if opts.search_method == "prev*" then
		local region_cover = find_textobject(
			ai_type,
			id,
			vim.tbl_deep_extend("force", opts, {search_method = "cover", n_times = 1})
		)
		if region_cover == nil then
			return find_textobject(
				ai_type,
				id,
				vim.tbl_deep_extend("force", opts, {search_method = "prev", n_times = opts.n_times})
			)
		else
			if opts.n_times == 1 then return region_cover end
			return find_textobject(
				ai_type,
				id,
				vim.tbl_deep_extend("force", opts, {search_method = "prev", n_times = opts.n_times - 1})
			)
		end
	end
	if opts.search_method == "next*" then
		local region_cover = find_textobject(
			ai_type,
			id,
			vim.tbl_deep_extend("force", opts, {search_method = "cover", n_times = 1})
		)

		if region_cover ~= nil then
			local pos_region_end = convert_pos(region_cover.to)
			local pos_cursor = get_pos_cursor()
			if pos_cursor > pos_region_end then
				region_cover = nil
			end
		end
		-- NOTE: find_textobject("i", ..., {search_method = "cover"}) still uses "a" to find textobject, so if the cursor on the space, we get a region that does not cover the cursor, exclude this case

		if region_cover == nil then
			return find_textobject(
				ai_type,
				id,
				vim.tbl_deep_extend("force", opts, {search_method = "next", n_times = opts.n_times})
			)
		else
			if opts.n_times == 1 then return region_cover end
			return find_textobject(
				ai_type,
				id,
				vim.tbl_deep_extend("force", opts, {search_method = "next", n_times = opts.n_times - 1})
			)
		end
	end
	return find_textobject(ai_type, id, opts)
end

-- # require("mini.ai").move_cursor_gen_rhs

-- https://github.com/nvim-mini/mini.nvim/issues/1093

require("mini.ai").move_cursor_cache = {
	-- ai_type = ...,
	-- id = ...,
}

require("mini.ai").move_cursor_rhs = function(side, ai_type, id, opts)
	local cmd = string.format(
		[[require("mini.ai").move_cursor(%s, %s, %s, %s)]],
		vim.inspect(side),
		vim.inspect(ai_type),
		vim.inspect(id),
		vim.inspect(opts, {newline = " "})
	)
	return "<cmd>lua " .. cmd .. "<cr>"
end

require("mini.ai").move_cursor_gen_rhs = function(side, ai_type, id, opts)
	return function()
		local cache = require("mini.ai").move_cursor_cache
		if ai_type == "cache" then
			cache.ai_type = cache.ai_type
		else
			cache.ai_type = ai_type
		end
		if id == "cache" then
			cache.id = cache.id
		elseif id == "ask" then
			local ok, tobj_id = pcall(vim.fn.getcharstr)
			if not ok or tobj_id == "\27" then
			-- ascii 27 is ESC
				return
			end
			cache.id = tobj_id
		else
			cache.id = id
		end
		local opts = vim.tbl_deep_extend("force", opts, {n_times = vim.v.count1})
		return require("mini.ai").move_cursor_rhs(side, cache.ai_type, cache.id, opts)
	end
end

vim.keymap.set({"n", "x", "o"}, "<cr>j",    require("mini.ai").move_cursor_gen_rhs("left",  "a", "ask", {search_method = "next"}),  {expr = true})
vim.keymap.set({"n", "x", "o"}, "<cr>k",    require("mini.ai").move_cursor_gen_rhs("left",  "a", "ask", {search_method = "prev*"}), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<cr>l",    require("mini.ai").move_cursor_gen_rhs("right", "a", "ask", {search_method = "next*"}), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<cr>h",    require("mini.ai").move_cursor_gen_rhs("right", "a", "ask", {search_method = "prev"}),  {expr = true})
vim.keymap.set({"n", "x", "o"}, "<space>j", require("mini.ai").move_cursor_gen_rhs("left",  "i", "ask", {search_method = "next"}),  {expr = true})
vim.keymap.set({"n", "x", "o"}, "<space>k", require("mini.ai").move_cursor_gen_rhs("left",  "i", "ask", {search_method = "prev*"}), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<space>l", require("mini.ai").move_cursor_gen_rhs("right", "i", "ask", {search_method = "next*"}), {expr = true})
vim.keymap.set({"n", "x", "o"}, "<space>h", require("mini.ai").move_cursor_gen_rhs("right", "i", "ask", {search_method = "prev"}),  {expr = true})

-- NOTE: for overlapping regions, only <cr>j( works as expected among <cr>j( <cr>k( <cr>l( <cr>h(

-- test:

-- (define lat?
--   (lambda (l)
--     (cond
--       ((null? l) #t)
--       ((atom? (car l)) (lat? (cdr l)))
--       (else #f))))

-- (define member?
--   (lambda (a lat)
--     (cond
--       ((null? lat) #f)
--       ((eq? (car lat) a) #t)
--       (else (member? a (cdr lat))))))

require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"left",
	"a",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "next"}
)()
]],
	from = "miniai_goto_head_a",
	name = "next",
	keys = {{"n", "x"}, "<cr>j"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"left",
	"a",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "prev*"}
)()
]],
	from = "miniai_goto_head_a",
	name = "prev",
	keys = {{"n", "x"}, "<cr>k"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"right",
	"a",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "next*"}
)()
]],
	from = "miniai_goto_tail_a",
	name = "next",
	keys = {{"n", "x"}, "<cr>l"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"right",
	"a",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "prev"}
)()
]],
	from = "miniai_goto_tail_a",
	name = "prev",
	keys = {{"n", "x"}, "<cr>h"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"left",
	"i",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "next"}
)()
]],
	from = "miniai_goto_head_i",
	name = "next",
	keys = {{"n", "x"}, "<space>j"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"left",
	"i",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "prev*"}
)()
]],
	from = "miniai_goto_head_i",
	name = "prev",
	keys = {{"n", "x"}, "<space>k"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"right",
	"i",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "next*"}
)()
]],
	from = "miniai_goto_tail_i",
	name = "next",
	keys = {{"n", "x"}, "<space>l"},
})
require("luaexec").add({
	code =
[[
return require("mini.ai").move_cursor_gen_rhs(
	"right",
	"i",
	require("luaexec").np_cache.is_repeat and "cache" or "ask",
	{search_method = "prev"}
)()
]],
	from = "miniai_goto_tail_i",
	name = "prev",
	keys = {{"n", "x"}, "<space>h"},
})

-- # frequently used motions

local map = function(lhs, side, ai_type, id, opts)
	opts = vim.tbl_deep_extend("force", opts, {n_times = vim.v.count1})
	vim.keymap.set(
		{"n", "x", "o"},
		lhs,
		function()
			require("mini.ai").move_cursor(
				side,
				ai_type,
				id,
				opts
			)
		end
	)
end

-- ## word

map("o", "left",  "i", "g", {search_method = "next"})
map("w", "left",  "i", "g", {search_method = "prev*"})
map("O", "right", "i", "g", {search_method = "next*"})
map("W", "right", "i", "g", {search_method = "prev"})

-- ## para emptiness_row 0

map("}", "left", "i", " ", {search_method = "next"})
map("{", "left", "i", " ", {search_method = "prev*"})

-- ## para emptiness_row 1

map("m", "left",  "i", "\r", {search_method = "next"})
map("v", "left",  "i", "\r", {search_method = "prev*"})
map("M", "right", "i", "\r", {search_method = "next*"})
map("V", "right", "i", "\r", {search_method = "prev"})
