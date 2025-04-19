require("mini.deps").add({
	source = "echasnovski/mini.pick",
})

require("mini.pick").setup({
	mappings = {
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
					vim.schedule(function()
						require("modexec").exec(item.code)
					end)
					return false
				end
			},
		},
		source = {
			items = vim.tbl_map(
				function(x)
					x.text = string.format(
						"(%s%s)%s",
						x.from,
						x.name and (" " .. x.name) or "",
						(" " .. x.code)
					)
					return x
				end,
				require("modexec").list_chunks()
			),
			choose = function(item)
				vim.schedule(function()
					require("modexec").exec(item.code)
				end)
			end,
			preview = function(buf_id, item)
				local lines = vim.split(item.code, "\n")
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

vim.keymap.set(
	{"n", "i", "c", "x", "s", "o", "t", "l"},
	"<c-cr>",
	require("mini.pick").registry.modexec_exec
)
-- vim.keymap.set(
-- 	{"n", "x"},
-- 	"<cr>",
-- 	require("mini.pick").registry.modexec_exec
-- )
vim.keymap.set("n", "fm", require("mini.pick").registry.modexec_mod)

vim.keymap.set("n", "f/", require("mini.pick").registry.registry)
vim.keymap.set("n", "f.", require("mini.pick").registry.resume)
vim.keymap.set("n", "ff", require("mini.pick").registry.files)
vim.keymap.set("n", "fn", require("mini.pick").registry.buffers)
vim.keymap.set("n", "fh", require("mini.pick").registry.help)
