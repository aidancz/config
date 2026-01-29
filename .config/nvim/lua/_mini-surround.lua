vim.pack.add({
	"https://github.com/nvim-mini/mini.surround",
})

-- # setup

-- ## config

local config =
{
	silent = true,
	custom_surroundings = {
	},
	highlight_duration = 500,
	mappings = {
		add         = "sa",
		delete      = "se",
		find        = "sn", -- TODO: nextprev
		find_left   = "sb", -- TODO: nextprev
		highlight   = "sv",
		replace     = "sx",

		suffix_next = "n",
		suffix_last = "b",
	},
	n_lines = 1024,
	respect_selection_type = true,
	search_method = "cover_or_next",
}

-- ## define extend

local extend = function(surroundings)
	config.custom_surroundings = vim.tbl_extend("force", config.custom_surroundings, surroundings)
end

-- ## extend(brackets)

extend({
	["("] = { input = { "%b()", "^.().*().$"       }, output = { left = "(",  right = ")"  } },
	["["] = { input = { "%b[]", "^.().*().$"       }, output = { left = "[",  right = "]"  } },
	["{"] = { input = { "%b{}", "^.().*().$"       }, output = { left = "{",  right = "}"  } },
	["<"] = { input = { "%b<>", "^.().*().$"       }, output = { left = "<",  right = ">"  } },
	[")"] = { input = { "%b()", "^.%s*().-()%s*.$" }, output = { left = "( ", right = " )" } },
	["]"] = { input = { "%b[]", "^.%s*().-()%s*.$" }, output = { left = "[ ", right = " ]" } },
	["}"] = { input = { "%b{}", "^.%s*().-()%s*.$" }, output = { left = "{ ", right = " }" } },
	[">"] = { input = { "%b<>", "^.%s*().-()%s*.$" }, output = { left = "< ", right = " >" } },
	i = {
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
	y = {
		input = {
			{
				"%b()",
				"%b[]",
				"%b{}",
				"%b<>",
			},
			"^.%s*().-()%s*.$",
		},
		output = {
			left = "(",
			right = ")",
		},
	},
})

-- ## extend(quotes)

extend({
	["'"] = { input = { "%b''", "^.().*().$" }, output = { left = "'", right = "'" } },
	['"'] = { input = { '%b""', "^.().*().$" }, output = { left = '"', right = '"' } },
	["`"] = { input = { "%b``", "^.().*().$" }, output = { left = "`", right = "`" } },
	e = {
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
	t = {
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
})

-- ## extend(user prompt)

extend({
	["?"] = {
		input = function()
			local left = MiniSurround.user_input("Left surrounding")
			if left == nil or left == "" then
				return
			end
			local right = MiniSurround.user_input("Right surrounding")
			if right == nil or right == "" then
				return
			end
			return { vim.pesc(left) .. "().-()" .. vim.pesc(right) }
		end,
		output = function()
			local left = MiniSurround.user_input("Left surrounding")
			if left == nil then
				return
			end
			local right = MiniSurround.user_input("Right surrounding")
			if right == nil then
				return
			end
			return { left = left, right = right }
		end,
	},
})

-- ## extend(function call)

extend({
	["f"] = {
		input = { "%f[%w_%.][%w_%.]+%b()", "^.-%(().*()%)$" },
		output = function()
			local fun_name = MiniSurround.user_input("Function name")
			if fun_name == nil then
				return nil
			end
			return { left = ("%s("):format(fun_name), right = ")" }
		end,
	},
})

-- ## extend(sgml tag)

extend({
	["T"] = {
		input = { "<(%w-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
		output = function()
			local tag_full = MiniSurround.user_input("Tag")
			if tag_full == nil then
				return nil
			end
			local tag_name = tag_full:match("^%S*")
			return { left = "<" .. tag_full .. ">", right = "</" .. tag_name .. ">" }
		end,
	},
})

-- ## setup(config)

require("mini.surround").setup(config)
