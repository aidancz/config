require("mini.deps").add({
	source = "echasnovski/mini.pick",
})

require("mini.pick").setup({
	mappings = {
		caret_home = {
		-- https://github.com/echasnovski/mini.nvim/issues/513#issuecomment-1764784504
			char = "<home>",
			func = function()
				local mappings = require("mini.pick").get_picker_opts().mappings
				local keys = string.rep(mappings.caret_left, 10)
				vim.api.nvim_input(keys)
			end,
		},
		caret_end = {
		-- https://github.com/echasnovski/mini.nvim/issues/513#issuecomment-1764784504
			char = "<end>",
			func = function()
				local mappings = require("mini.pick").get_picker_opts().mappings
				local keys = string.rep(mappings.caret_right, 10)
				vim.api.nvim_input(keys)
			end,
		},
	},
	options = {
		content_from_bottom = false,
	},
	source = {
		name = "<no name>",
	},
	window = {
		config = {
			relative = "editor",
			height   = math.floor(0.8 * vim.o.lines),
			width    = math.floor(0.8 * vim.o.columns),
			anchor   = "NW",
			row      = math.floor(0.1 * vim.o.lines)   - 1,
			col      = math.floor(0.1 * vim.o.columns) - 1,
		},
		prompt_caret = "█",
		prompt_prefix = "",
	},
})

vim.ui.select = require("mini.pick").ui_select

require("mini.pick").registry.registry = function()
	local items = vim.tbl_keys(require("mini.pick").registry)
	table.sort(items)
	require("mini.pick").start({
		source = {
			items = items,
			choose = function(item)
				require("mini.pick").registry[item]()
			end,
		},
	})
end

require("mini.pick").registry.modexec_mod = function()
	require("mini.pick").start({
		source = {
			items = require("modexec").list_names(),
			choose = function(item)
				require("modexec").set_current_mode(item)
			end,
		},
	})
end

require("mini.pick").registry.modexec_exec = function()
	local chunks = require("modexec").list_chunks()
	for _, i in ipairs(chunks) do
		i.tag = string.format(
			"(%s%s)",
			i.from,
			i.name and (" " .. i.name) or ""
		)
		i.text = string.format(
			"%-32s %s %s",
			i.tag,
			i.code,
			i.desc or ""
		)
	end
	require("mini.pick").start({
		source = {
			items = chunks,
			choose = function(item)
				vim.schedule(function()
					require("modexec").exec(item.code)
				end)
			end,
			preview = function(buf_id, item)
				local lines = {}

				local split = function(s)
					if s == nil or s == "" then
						return {""}
					else
						return vim.split(s, "\n", {trimempty = true})
					end
				end
				vim.list_extend(lines, split(item.tag))
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, split(item.code))
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, split(item.desc))

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
				-- vim.api.nvim_set_option_value("filetype", "lua", {buf = buf_id})
			end,
		},
	})
end

require("mini.pick").registry.modexec_luaeval_history = function()
-- borrow code from `require("mini.extra").pickers.history`
	local history1 = {}
	for i = vim.fn.histnr("cmd"), 1, -1 do
		local cmd = vim.fn.histget("cmd", i)
		if cmd ~= "" then
			table.insert(
				history1,
				{
					histnr = i,
					cmd = cmd,
				}
			)
		end
	end
	local history2 = {}
	for _, i in ipairs(history1) do
		local code_tbl = require("modexec").cmd2code(i.cmd)
		if code_tbl then
			i.code_tbl = code_tbl
			table.insert(history2, i)
		end
	end
	for _, i in ipairs(history2) do
		i.text = string.format(
			"%8s %s",
			i.histnr,
			table.concat(i.code_tbl, "\n")
		)
	end

	local timer = vim.uv.new_timer()
	timer:start(
		0,
		2,
		function()
			local picker_state = require("mini.pick").get_picker_state()
			if
				picker_state
				and
				not picker_state.is_busy
			then
				timer:stop()
				vim.api.nvim_input("\t")
			end
		end
	)

	require("mini.pick").start({
		options = {
			content_from_bottom = true,
		},
		source = {
			items = history2,
			choose = function(item)
				require("luaeval").buf_set_lines(item.code_tbl)
				vim.schedule(function()
					require("luaeval").open()
				end)
			end,
			preview = function(buf_id, item)
				local lines = {}

				vim.list_extend(lines, {tostring(item.histnr)})
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, item.code_tbl)

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
			end,
		},
	})
end

require("nofrils").clear("^MiniPick")

vim.api.nvim_set_hl(0, "MiniPickBorderBusy",    {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniPickCursor",        {link = "nofrils_transparent"})
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent",  {link = "nofrils_reverse"})
vim.api.nvim_set_hl(0, "MiniPickMatchMarked",   {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "MiniPickMatchRanges",   {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "MiniPickPreviewLine",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "MiniPickPreviewRegion", {link = "nofrils_blue_bg"})

require("modexec").add_mode({
	name = "modexec",
	chunks = {
		{
			code = [[require("mini.pick").registry.modexec_exec()]],
			gkey = {{"n", "i", "c", "x", "s", "o", "t", "l"}, "<c-cr>"},
			gkey_shortcut = {{"n", "x"}, "fj"},
		},
		{
			code = [[require("mini.pick").registry.modexec_mod()]],
			gkey = {{"n", "x"}, "fm"},
		},
	},
})

require("modexec").add_mode({
	name = "mini.pick",
	chunks = {
		{
			code = [[require("mini.pick").registry.registry()]],
			gkey = {"n", "f/"},
		},
		{
			code = [[require("mini.pick").registry.resume()]],
			gkey = {"n", "f."},
		},
		{
			code = [[require("mini.pick").registry.files()]],
			gkey = {"n", "ff"},
		},
		{
			code =
[[
require("mini.pick").builtin.files(
	nil,
	{
		source = {
			cwd = require("mini.misc").find_root(),
		},
	}
)
]],
			gkey = {"n", "fd"},
		},
		{
			code = [[require("mini.pick").registry.buffers()]],
			gkey = {"n", "fl"},
		},
		{
			code = [[require("mini.pick").registry.help()]],
			gkey = {"n", "fh"},
		},
		{
			code = [[require("mini.pick").registry.modexec_luaeval_history()]],
			gkey = {"n", "f<up>"},
		},
	},
})
