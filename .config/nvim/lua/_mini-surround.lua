require("mini.deps").add({
	source = "echasnovski/mini.surround",
})

require("mini.surround").setup({
	silent = true,
	custom_surroundings = {

		["("] = { input = { "%b()", "^.().*().$"       }, output = { left = "(",  right = ")"  } },
		["["] = { input = { "%b[]", "^.().*().$"       }, output = { left = "[",  right = "]"  } },
		["{"] = { input = { "%b{}", "^.().*().$"       }, output = { left = "{",  right = "}"  } },
		["<"] = { input = { "%b<>", "^.().*().$"       }, output = { left = "<",  right = ">"  } },
		[")"] = { input = { "%b()", "^.%s*().-()%s*.$" }, output = { left = "( ", right = " )" } },
		["]"] = { input = { "%b[]", "^.%s*().-()%s*.$" }, output = { left = "[ ", right = " ]" } },
		["}"] = { input = { "%b{}", "^.%s*().-()%s*.$" }, output = { left = "{ ", right = " }" } },
		[">"] = { input = { "%b<>", "^.%s*().-()%s*.$" }, output = { left = "< ", right = " >" } },
		b = {
			input = {
				{
					"%b()",
					"%b[]",
					"%b{}",
					"%b<>",
				},
				"^.().*().$",
			},
			output = {
				left = "(",
				right = ")",
			},
		},

		["'"] = { input = { "%b''", "^.().*().$" }, output = { left = "'", right = "'" } },
		['"'] = { input = { '%b""', "^.().*().$" }, output = { left = '"', right = '"' } },
		["`"] = { input = { "%b``", "^.().*().$" }, output = { left = "`", right = "`" } },
		q = {
			input = {
				{
					"%b''",
					'%b""',
					"%b``",
				},
				"^.().*().$",
			},
			output = {
				left = '"',
				right = '"',
			},
		},

		Q = {
			input = {
				{
					"%'.-%'",
					'%".-%"',
					"%`.-%`",
				},
				"^.().*().$",
			},
			output = {
				left = '"',
				right = '"',
			},
		},

	},
	mappings = {
		add            = ",s",
		delete         = "ds",
		find           = "",
		find_left      = "",
		highlight      = "",
		replace        = "cs",
		update_n_lines = "",

		suffix_next = "n",
		suffix_last = "N",
	},
	respect_selection_type = true,
	n_lines = 1024,
	search_method = "cover_or_next",
})



-- vim.keymap.del("x", "ys")
-- vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], {silent = true})
vim.keymap.set("n", ",ss", ",s_", {remap = true})
vim.keymap.set("n", ",S", ",s$", {remap = true})
-- vim.keymap.set("", "s", "<nop>") -- if using `s` for prefix
