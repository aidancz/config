require("mini.deps").add({
	source = "nvim-mini/mini.surround",
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
		add            = "",
		delete         = "",
		find           = "",
		find_left      = "",
		highlight      = "",
		replace        = "",
		update_n_lines = "",

		suffix_next = "n",
		suffix_last = "b",
	},
	respect_selection_type = true,
	n_lines = 1024,
	search_method = "cover_or_next",
})
