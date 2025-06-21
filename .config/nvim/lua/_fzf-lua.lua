-- https://github.com/ibhagwan/fzf-lua/issues/140

require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	"hide",
	winopts = {
		border = "bold",
		zindex = 200,
		backdrop = 100,
		fullscreen = true,
		preview = {
			border = "bold",
			winopts = {
				number = false,
			},
		},
	},
	keymap = {
		builtin = {
			true,
		},
		fzf = {
			true,
			["ctrl-a"] = "first",
			["ctrl-e"] = "last",
		},
	},
	fzf_opts = {
		["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
		-- https://github.com/ibhagwan/fzf-lua/wiki#custom-history
	},
})

require("fzf-lua").register_ui_select()

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
				"%8s %s%s",
				x.histnr,
				x.histname,
				x.entry
			)
		end,
		history
	)

	require("fzf-lua").fzf_exec(
		contents
	)
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

require("luaexec").add({
	code = [[require("fzf-lua").buffers()]],
	from = "fzf-lua",
	keys = {"n", "rb"},
})

require("luaexec").add({
	code = [[require("fzf-lua").helptags()]],
	from = "fzf-lua",
	keys = {"n", "rh"},
})

-------------
do return end
-------------

vim.keymap.set("n", "f/", require("fzf-lua").builtin)
vim.keymap.set("n", "f.", require("fzf-lua").resume)
vim.keymap.set("n", "ff", require("fzf-lua").files)
vim.keymap.set("n", "fn", require("fzf-lua").buffers)
vim.keymap.set("n", "fh", require("fzf-lua").helptags)

-- vim.keymap.set(
-- 	"n",
-- 	"fm",
-- 	function()
-- 		require("fzf-lua").fzf_exec(
-- 			require("luaexec").list_mode_names(),
-- 			{
-- 				actions = {
-- 					default = function(selected, opts)
-- 						require("luaexec").set_current_mode(selected[1])
-- 					end,
-- 				},
-- 			}
-- 		)
-- 	end
-- )
