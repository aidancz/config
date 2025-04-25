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
	local m = require("mini.pick")
	local items = vim.tbl_keys(m.registry)
	table.sort(items)
	m.start({
		source = {
			items = items,
			name = "Registry",
			choose = function(item)
				m.registry[item]()
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
	require("mini.pick").start({
		mappings = {
			choose_not_stop = {
				char = "<s-cr>",
				func = function()
					local item = require("mini.pick").get_picker_matches().current

					local picker_state = require("mini.pick").get_picker_state()
					vim.api.nvim_win_call(
						picker_state.windows.target,
						function()
							require("modexec").exec(item.code)
						end
					)

					return false
				end
			},
		},
		source = {
			items = vim.tbl_map(
				function(x)
					local tag = string.format(
						"(%s%s)",
						x.from,
						x.name and (" " .. x.name) or ""
					)
					local code = x.code
					x.text = string.format(
						"%-31s\n%s",
						tag,
						code
					)
					return x
				end,
				require("modexec").list_chunks()
			),
			choose = function(item)
				local picker_state = require("mini.pick").get_picker_state()
				vim.api.nvim_win_call(
					picker_state.windows.target,
					function()
						require("modexec").exec(item.code)
					end
				)
			end,
			preview = function(buf_id, item)
				local lines = {}

				local code = vim.split(item.code, "\n", {trimempty = true})
				vim.list_extend(lines, code)

				if item.desc then
					local desc = vim.split(item.desc, "\n", {trimempty = true})
					for n, i in ipairs(desc) do
						desc[n] = "-- " .. i
					end
					vim.list_extend(lines, desc)
				end

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
				vim.api.nvim_set_option_value("filetype", "lua", {buf = buf_id})
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
	},
})
