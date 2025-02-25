-- vim.opt.runtimepath:prepend("~/sync_git/mini.nvim")

require("mini.deps").add({
	source = "echasnovski/mini.ai",
})

require("mini.ai").setup({
	silent = true,
	custom_textobjects = {

		['('] = { '%b()', '^.().*().$' },
		['['] = { '%b[]', '^.().*().$' },
		['{'] = { '%b{}', '^.().*().$' },
		['<'] = { '%b<>', '^.().*().$' },
		[')'] = { '%b()', '^.%s*().-()%s*.$' },
		[']'] = { '%b[]', '^.%s*().-()%s*.$' },
		['}'] = { '%b{}', '^.%s*().-()%s*.$' },
		['>'] = { '%b<>', '^.%s*().-()%s*.$' },
		b = {
			{
				'%b()',
				'%b[]',
				'%b{}',
				'%b<>',
			},
			'^.().*().$'
		},

		-- https://github.com/echasnovski/mini.nvim/issues/1281
		["'"] = { "%b''", '^.().*().$' },
		['"'] = { '%b""', '^.().*().$' },
		['`'] = { '%b``', '^.().*().$' },
		q = {
			{
				"%b''",
				'%b""',
				'%b``',
			},
			'^.().*().$'
		},
		-- 金铁击石全无力 大圣天蓬遭虎欺 枪刀戟剑浑不避 石猴似你不似你

		d = {
			{
				"%'.-%'",
				'%".-%"',
				'%`.-%`',
			},
			'^.().*().$'
		},

		["0"] = require("mini.extra").gen_ai_spec.number(),

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
			local para = require("paramo/para3")

			if ai_type == "i" then
				para.setup({
					include_more_indent = false,
					include_empty_lines = false,
				})
			else
				para.setup({
					include_more_indent = false,
					include_empty_lines = true,
				})
			end

			local lnum_cursor = vim.fn.line(".")
			local lnum_1
			if para.head_p(lnum_cursor) then
				lnum_1 = lnum_cursor
			else
				lnum_1 = para.backward_pos(lnum_cursor, para.head_p)
			end
			local lnum_2
			if para.tail_p(lnum_cursor) then
				lnum_2 = lnum_cursor
			else
				lnum_2 = para.forward_pos(lnum_cursor, para.tail_p)
			end

			return {
				from = {
					line = lnum_1,
					col = 1,
				},
				to = {
					line = lnum_2,
					col = 1,
				},
				vis_mode = "V",
			}
		end,

		o = function(ai_type)
			local para = require("paramo/para3")

			if ai_type == "i" then
				para.setup({
					include_more_indent = true,
					include_empty_lines = false,
				})
			else
				para.setup({
					include_more_indent = true,
					include_empty_lines = true,
				})
			end

			local lnum_cursor = vim.fn.line(".")
			local lnum_1
			if para.head_p(lnum_cursor) then
				lnum_1 = lnum_cursor
			else
				lnum_1 = para.backward_pos(lnum_cursor, para.head_p)
			end
			local lnum_2
			if para.tail_p(lnum_cursor) then
				lnum_2 = lnum_cursor
			else
				lnum_2 = para.forward_pos(lnum_cursor, para.tail_p)
			end

			return {
				from = {
					line = lnum_1,
					col = 1,
				},
				to = {
					line = lnum_2,
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
					col = math.max(1, string.len(vim.fn.getline("$"))),
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
