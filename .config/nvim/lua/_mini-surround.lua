MiniDeps.add({
	source = "echasnovski/mini.surround",
})

require("mini.surround").setup({
	silent = true,
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

		suffix_next = "n",
		suffix_last = "N",
	},
	respect_selection_type = true,
	search_method = "cover_or_next",
})
vim.keymap.del("x", "ys")
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], {silent = true})
vim.keymap.set("n", "yss", "ys_", {remap = true})
-- vim.keymap.set("", "s", "<nop>") -- if using `s` for prefix
