-- https://github.com/ibhagwan/fzf-lua/issues/140

require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
	depends = {
		{
			source = "otavioschwanck/fzf-lua-enchanted-files",
		},
	},
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
		zindex = 200,
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
			true,
			["<f1>"]         = "hide",
			["<f2>"]         = false,
			["<c-h>"]        = "toggle-help",
			["<f11>"]        = "toggle-fullscreen",
			["<pageup>"]     = "preview-half-page-up",
			["<pagedown>"]   = "preview-half-page-down",
			["<del>"]        = "preview-reset",
			["<c-pageup>"]   = "preview-top",
			["<c-pagedown>"] = "preview-bottom",
		},
		fzf = {
			true,
			["ctrl-s"] = "first",
			["ctrl-e"] = "last",
			["f10"]    = "toggle-sort",
		},
	},
	actions = {
		files = {
			true,
			["ctrl-s"] = false,
		},
		-- buffers = {
		-- 	true,
		-- 	["ctrl-s"] = false,
		-- },
	},
	fzf_opts = {
		["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
		-- https://github.com/ibhagwan/fzf-lua/wiki#custom-history
	},

	-- # picker options

	grep = {
		RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
	},
})

require("fzf-lua").register_ui_select()

require("fzf-lua").helpfunc_split = function(s)
	if s == nil or s == "" then
		return {""}
	else
		return vim.split(s, "\n", {trimempty = true})
	end
end
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
					vim.schedule(function()
						vim.api.nvim_feedkeys(histname .. entry .. "\n", "nt", true)
					end)
				end,
			},
		},
		opts
	)

	require("fzf-lua").fzf_exec(contents, opts)
end

require("nofrils").clear("^FzfLua")

vim.api.nvim_set_hl(0, "FzfLuaCursorLine", {link = "nofrils_reverse"})

require("luaexec").add({
	code = [[require("fzf-lua").builtin()]],
	from = "fzf-lua",
	keys = {"n", "r<space>"},
})

require("luaexec").add({
	code = [[require("fzf-lua").resume()]],
	from = "fzf-lua",
	keys = {"n", "rr"},
})

require("luaexec").add({
	code = [[require("fzf-lua").files({cwd = vim.fs.root(0, ".git") or vim.fn.getcwd()})]],
	from = "fzf-lua",
	keys = {"n", "rk"},
})

-- require("luaexec").add({
-- 	code = [[require("fzf-lua-enchanted-files").files({cwd = vim.fs.root(0, ".git") or vim.fn.getcwd()})]],
-- 	from = "fzf-lua",
-- 	keys = {"n", "rk"},
-- })

require("luaexec").add({
	code = [[require("fzf-lua").buffers()]],
	from = "fzf-lua",
	keys = {"n", "rb"},
})

require("luaexec").add({
	code =
[[
require("fzf-lua").helptags({
	actions = {
		["ctrl-s"] = false,
	},
})
]],
	from = "fzf-lua",
	keys = {"n", "rh"},
})

require("luaexec").add({
	code = [[require("fzf-lua").custom_history({histname = ":"})]],
	from = "fzf-lua",
	keys = {"n", "r:"},
})

require("luaexec").add({
	code = [[require("fzf-lua").custom_history({histname = "/"})]],
	from = "fzf-lua",
	keys = {"n", "r/"},
})

require("luaexec").add({
	code = [[require("fzf-lua").custom_history({histname = "?"})]],
	from = "fzf-lua",
	keys = {"n", "r?"},
})

require("luaexec").add({
	code = [[require("fzf-lua").blines()]],
	from = "fzf-lua",
	keys = {"n", "rl"},
})

require("luaexec").add({
	code = [[require("fzf-lua").lines()]],
	from = "fzf-lua",
	keys = {"n", "rL"},
})

require("luaexec").add({
	code = [[require("fzf-lua").live_grep({cwd = vim.fs.root(0, ".git") or vim.fn.getcwd()})]],
	from = "fzf-lua",
	keys = {"n", "rw"},
})
