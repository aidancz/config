return
{
	"echasnovski/mini.nvim",
	version = false,
	config = function()

		require("mini.ai").setup({
			custom_textobjects = {
				['('] = { '%b()', '^.().*().$' },
				[')'] = { '%b()', '^.%s*().-()%s*.$' },
				['['] = { '%b[]', '^.().*().$' },
				[']'] = { '%b[]', '^.%s*().-()%s*.$' },
				['{'] = { '%b{}', '^.().*().$' },
				['}'] = { '%b{}', '^.%s*().-()%s*.$' },
				['<'] = { '%b<>', '^.().*().$' },
				['>'] = { '%b<>', '^.%s*().-()%s*.$' },
				b = {{'%b()', '%b[]', '%b{}', '%b<>'}, '^.().*().$'},

				-- ['"'] = { '"().-()"' },
				-- https://github.com/echasnovski/mini.nvim/issues/1281
				["'"] = { "'.-'", '^.().*().$' },
				['"'] = { '".-"', '^.().*().$' },
				['`'] = { '`.-`', '^.().*().$' },
				q = { { "'.-'", '".-"', '`.-`' }, '^.().*().$' },
				-- 金铁击石全无力 大圣天蓬遭虎欺 枪刀戟剑浑不避 石猴似你不似你

				n = require("mini.extra").gen_ai_spec.number(),
				c = function(ai_type)
				-- current line
					local line_num = vim.fn.line(".")
					local col_max = math.max(1, #vim.api.nvim_get_current_line())
					local region = {from = {line = line_num, col = 1}, to = {line = line_num, col = col_max}}
					if ai_type == "i" then
						region.vis_mode = "v"
					elseif ai_type == "a" then
						region.vis_mode = "V"
					end
					return region
				end,
				i = function(ai_type)
					local region = (require("mini.extra").gen_ai_spec.indent())(ai_type)
					for _, i in ipairs(region) do
						i.vis_mode = "V"
					end
					return region
				end,
				e = function(ai_type)
				-- entire buffer
					local region = (require("mini.extra").gen_ai_spec.buffer())("a")
					region.vis_mode = "V"
					return region
				end,
			},
			mappings = {
				around_next = "al",
				inside_next = "il",
				around_last = "ah",
				inside_last = "ih",

				goto_left  = "gh",
				goto_right = "gl",
			},
			n_lines = 1024,
			search_method = "cover_or_next",
		})

		require("mini.align").setup({
			mappings = {
				start = "gn",
				start_with_preview = "gN",
			},
		})
		vim.keymap.set("n", "gnn", "gn_", {remap = true})

		require("mini.bracketed").setup({})

		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {add = "┃", change = "●", delete = "━"},
				priority = 0,
			},
			delay = {
				text_change = 100,
			},
			mappings = {
				apply = "ga",
				reset = "gr",
				textobject = "gh",
			},
		})
		vim.api.nvim_set_hl(0, "MiniDiffOverChange", {link = "nofrils-yellow"})
		vim.api.nvim_set_hl(0, "MiniDiffOverContext", {link = "nofrils-default"})

		require("mini.extra").setup({})

		require("mini.icons").setup({
			style = "ascii",
		})

		require("mini.move").setup({
			options = {
				reindent_linewise = false,
			},
		})

		require("mini.operators").setup({
			replace = {
				prefix = "s",
				reindent_linewise = false,
			},
		})
		vim.keymap.set("n", "S", "s$", {remap = true})

		require("mini.surround").setup({
			custom_surroundings = {
				['('] = { input = { '%b()', '^.().*().$'       }, output = { left = '(',  right = ')'  } },
				[')'] = { input = { '%b()', '^.%s*().-()%s*.$' }, output = { left = '( ', right = ' )' } },
				['['] = { input = { '%b[]', '^.().*().$'       }, output = { left = '[',  right = ']'  } },
				[']'] = { input = { '%b[]', '^.%s*().-()%s*.$' }, output = { left = '[ ', right = ' ]' } },
				['{'] = { input = { '%b{}', '^.().*().$'       }, output = { left = '{',  right = '}'  } },
				['}'] = { input = { '%b{}', '^.%s*().-()%s*.$' }, output = { left = '{ ', right = ' }' } },
				['<'] = { input = { '%b<>', '^.().*().$'       }, output = { left = '<',  right = '>'  } },
				['>'] = { input = { '%b<>', '^.%s*().-()%s*.$' }, output = { left = '< ', right = ' >' } },
			},
			mappings = {
				add     = "ys",
				delete  = "ds",
				replace = "cs",

				suffix_last = "h",
				suffix_next = "l",
			},
			respect_selection_type = true,
			search_method = "cover_or_next",
		})
		vim.keymap.del("x", "ys")
		vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], {silent = true})
		vim.keymap.set("n", "yss", "ys_", {remap = true})
		-- vim.keymap.set("", "s", "<nop>") -- if using `s` for prefix

		-- require("mini.trailspace").setup({})
		-- vim.api.nvim_set_hl(0, "MiniTrailspace", {link = "nofrils-yellow-bg"})

	end,
}
