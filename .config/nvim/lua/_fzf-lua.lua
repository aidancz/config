-- https://github.com/ibhagwan/fzf-lua/issues/140

require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
	checkout = "b51b97f~",
})

require("fzf-lua").setup({
	"hide",
	help_open_win = function(buffer, enter, config)
		config = vim.tbl_extend(
			"force",
			config,
			{
				relative = "editor",
				anchor = "NW",
				border = "none",
				row = 0,
				col = 0,
				width = vim.o.columns,
				height = vim.o.lines,
				style = "minimal",
			}
		)
		return vim.api.nvim_open_win(buffer, enter, config)
	end,
	winopts = {
		border = "none",
		zindex = 201,
		backdrop = 100,
		fullscreen = true,
		preview = {
			border = "none",
			vertical = "up:50%",
			horizontal = "right:50%",
			layout = "horizontal",
			-- flip_columns = math.floor(vim.o.columns / 2),
			delay = 0,
			winopts = {
				number = false,
			},
		},
	},
	keymap = {
		builtin = {
			false,
			["<f1>"] = "hide",
			-- ["<f2>"] = false,
			["<c-h>"] = "toggle-help",
			["<f11>"] = "toggle-fullscreen",

			["<pagedown>"] = "preview-page-down",
			["<pageup>"]   = "preview-page-up",
			["<c-end>"]    = "preview-bottom",
			["<c-home>"]   = "preview-top",
			["<del>"]      = "preview-reset",

		},
		fzf = {
			false,
			-- configure FZF_DEFAULT_OPTS instead
		},
	},
	actions = {
		files = {
			false,
			["enter"] = require("fzf-lua").actions.file_edit,
			["ctrl-q"] = require("fzf-lua").actions.file_sel_to_qf,
		},
	},
	fzf_opts = {
		["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
		-- https://github.com/ibhagwan/fzf-lua/wiki#custom-history
	},

	-- # picker options
	-- https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua

	-- defaults = {
	-- 	actions = {
	-- 		["ctrl-f"] = false,
	-- 		["ctrl-d"] = false,
	-- 		["ctrl-g"] = false,
	-- 		["ctrl-s"] = false,
	-- 	},
	-- },

	builtin = {
		actions = {
			["enter"] = require("fzf-lua").actions.run_builtin,
		},
	},

	grep = {
		RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
	},

	helptags = {
		actions = {
			["enter"] = require("fzf-lua").actions.help,
		},
	},
})

-- # clear default actions

local clear_actions
clear_actions = function(t, seen)
-- set all key "actions" to value {} recursively
	seen = seen or {}

	if seen[t] then return end
	seen[t] = true
	-- prevent infinite loops on self-referential tables

	for k, v in pairs(t) do
		if k == "actions" then
			t[k] = {}
		end
		if type(v) == "table" then
			clear_actions(v, seen)
		end
	end
end
clear_actions(require("fzf-lua").defaults)

-- # do not ignore my go-up autocmd

require("fzf-lua").utils.eventignore = function(func, scope)
	return func()
end

-- # use go-up for zz

require("fzf-lua").utils.zz = function()
	if require("fzf-lua").utils.is_term_buffer() then return end
	require("luaexec").registry["go-up"]["recenter 1/4"]()
end

-- # vim.ui.select

require("fzf-lua").register_ui_select()

-- # help function: split string

require("fzf-lua").helpfunc_split = function(s)
	if s == nil or s == "" then
		return {""}
	else
		return vim.split(s, "\n", {trimempty = true})
	end
end

-- # help function: form feed

require("fzf-lua").form_feed_foldexpr = function()
	local line = vim.fn.getline(vim.v.lnum)
	local first_char = string.sub(line, 1, 1)
	if first_char == "" then
		return 1
	else
		return 0
	end
end

require("fzf-lua").form_feed_options_hack = {
-- https://stackoverflow.com/questions/5347522/is-it-possible-to-display-page-feed-symbols-differently-in-vim
	foldenable = true,
	foldmethod = "expr",
	foldexpr = "v:lua.require'fzf-lua'.form_feed_foldexpr()",
	foldminlines = 0,
	foldtext = "'" .. string.rep("-", vim.o.columns) .. "'",
	foldlevel = 0,
	-- foldclose = "all",
}

-- # custom provider: example

require("fzf-lua").custom_example = function()
-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#lua-function-as-contents
	require("fzf-lua").fzf_exec(
		function(fzf_cb)
			local co
			co = coroutine.create(function()
				for i = 1, 1234567 do
					fzf_cb(i, function() coroutine.resume(co) end)
					coroutine.yield()
				end
				fzf_cb()
			end)
			coroutine.resume(co)
		end
	)
end

-- # custom provider: history

---@param opts {
---	histname: ":"|"/"|"?", -- `:h hist-names`
---}
require("fzf-lua").custom_history = function(opts)
	local list_history = function(histname)
		local history = {}
		for i = vim.fn.histnr(histname), 1, -1 do
			local entry = vim.fn.histget(histname, i)
			if entry ~= "" then
				table.insert(
					history,
					{
						histnr = i,
						histname = histname,
						entry = entry,
					}
				)
			end
		end
		return history
	end
	local history = list_history(opts.histname)

	local contents = vim.tbl_map(
		function(x)
			return
			string.format(
				"%8s%s%s%s%s",
				x.histnr,
				require("fzf-lua").utils.nbsp,
				x.histname,
				require("fzf-lua").utils.nbsp,
				x.entry
			)
		end,
		history
	)

	opts = vim.tbl_deep_extend(
		"force",
		{
			fzf_opts = {
				["--layout"] = "default",
			},
			actions = {
				["default"] = function(selected, opts)
					local components = vim.split(selected[1], require("fzf-lua").utils.nbsp)
					local histname = components[2]
					local entry = components[3]
					local key = histname .. entry .. "\n"
					vim.schedule(function()
						feedkeys(key, "nt")
					end)
				end,
			},
		},
		opts
	)

	require("fzf-lua").fzf_exec(contents, opts)
end

-- # highlight group

require("nofrils").clear("^FzfLua")

vim.api.nvim_set_hl(0, "FzfLuaCursorLine", {link = "nofrils_reverse"})

-- # luaexec

require("luaexec").add({
	code = [[require("fzf-lua").builtin()]],
	from = "fzf-lua",
	keys = {"n", "s<cr>"},
})

require("luaexec").add({
	code = [[require("fzf-lua").resume()]],
	from = "fzf-lua",
	keys = {"n", "s<space>"},
})

require("luaexec").add({
	code = [[require("fzf-lua").files({cwd = vim.fs.root(0, ".git") or vim.fn.getcwd()})]],
	from = "fzf-lua",
	keys = {"n", "sk"},
})

require("luaexec").add({
	code = [[require("fzf-lua").buffers()]],
	from = "fzf-lua",
	keys = {"n", "sl"},
})

require("luaexec").add({
	code = [[require("fzf-lua").helptags()]],
	from = "fzf-lua",
	keys = {"n", "sh"},
})

require("luaexec").add({
	code = [[require("fzf-lua").custom_history({histname = ":"})]],
	from = "fzf-lua",
	keys = {"n", "s:"},
})

require("luaexec").add({
	code = [[require("fzf-lua").custom_history({histname = "/"})]],
	from = "fzf-lua",
	keys = {"n", "s/"},
})

require("luaexec").add({
	code = [[require("fzf-lua").custom_history({histname = "?"})]],
	from = "fzf-lua",
	keys = {"n", "s?"},
})

require("luaexec").add({
	code = [[require("fzf-lua").blines()]],
	from = "fzf-lua",
	keys = {"n", "s."},
})

require("luaexec").add({
	code = [[require("fzf-lua").lines()]],
	from = "fzf-lua",
	keys = {"n", "s,"},
})

require("luaexec").add({
	code = [[require("fzf-lua").live_grep({cwd = vim.fs.root(0, ".git") or vim.fn.getcwd()})]],
	from = "fzf-lua",
	keys = {"n", "sr"},
})
