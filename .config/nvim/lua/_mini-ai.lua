vim.opt.runtimepath:prepend("~/sync_git/mini.nvim")

-- MiniDeps.add({
-- 	source = "echasnovski/mini.ai",
-- })

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

		-- s = {
		-- 	{
		-- 		'%(.-%)',
		-- 		'%[.-%]',
		-- 		'%{.-%}',
		-- 		'%<.-%>',
		-- 		"%'.-%'",
		-- 		'%".-%"',
		-- 		'%`.-%`',
		-- 	},
		-- 	'^.().*().$'
		-- },

		d = require("mini.extra").gen_ai_spec.number(),

		l = function(ai_type)
			local row = vim.fn.line(".")
			local col_end = string.len(vim.fn.getline("."))

			local to
			if col_end ~= 0 then
				to = {
					line = row,
					col = col_end,
				}
			else
				to = nil
			end

			local vis_mode
			if ai_type == "i" then
				vis_mode = "v"
			else
				vis_mode = "V"
			end

			return {
				from = {
					line = row,
					col = 1,
				},
				to = to,
				vis_mode = vis_mode,
			}
		end,

		i = function(ai_type)
			local M = {}

			M.match = function(str)
				return string.match(str, "^(%s*)(.*)$")
			end

			M.sibling_or_descendant = function(row)
				local line = vim.fn.getline(row)
				local capture1, capture2 = M.match(line)
				if ai_type == "i" then
					if M.capture1_dot == "" and M.capture2_dot == "" then
						return capture1 == "" and capture2 == ""
					end
					if M.capture1_dot == "" and M.capture2_dot ~= "" then
						return capture1 == "" and capture2 ~= ""
					end
					return capture1 == M.capture1_dot
				end
				if ai_type == "a" then
					if M.capture1_dot == "" and M.capture2_dot == "" then
						return capture1 == "" and capture2 == ""
					end
					if M.capture1_dot == "" and M.capture2_dot ~= "" then
						return not (capture1 == "" and capture2 == "")
					end
					return string.find(capture1, "^" .. M.capture1_dot)
				end
			end

			M.row_before = function(row)
				if row == 1 then
					return row
				end
				if not M.sibling_or_descendant(row - 1) then
					return row
				end
				return M.row_before(row - 1)
			end

			M.row_after = function(row)
				if row == vim.fn.line("$") then
					return row
				end
				if not M.sibling_or_descendant(row + 1) then
					return row
				end
				return M.row_after(row + 1)
			end

			M.row_dot = vim.fn.line(".")
			-- `row_dot` means current row
			M.line_dot = vim.fn.getline(M.row_dot)
			M.capture1_dot, M.capture2_dot = M.match(M.line_dot)

			return {
				from = {
					line = M.row_before(M.row_dot),
					col = 1,
				},
				to = {
					line = M.row_after(M.row_dot),
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
		end

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
