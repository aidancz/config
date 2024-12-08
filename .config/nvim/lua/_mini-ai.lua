vim.opt.runtimepath:prepend("~/sync_git/mini.nvim")

-- MiniDeps.add({
-- 	source = "echasnovski/mini.ai",
-- })

require("mini.ai").setup({
	silent = true,
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

		c = require("mini.extra").gen_ai_spec.number(),
		-- count number
		l = function(ai_type)
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
