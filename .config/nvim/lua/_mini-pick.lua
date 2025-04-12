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

require("mini.pick").registry.registry = function()
	local m = require("mini.pick")
	local items = vim.tbl_keys(m.registry)
	table.sort(items)
	m.start({
		source = {
			items = items,
			name = "Registry",
			choose = function(item)
				if item == nil then return end
				m.registry[item]()
			end,
		},
	})
end

require("nofrils").clear("^MiniPick")

vim.api.nvim_set_hl(0, "MiniPickBorderBusy",    {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent",  {link = "nofrils_reverse"})
vim.api.nvim_set_hl(0, "MiniPickMatchMarked",   {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "MiniPickMatchRanges",   {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "MiniPickPreviewLine",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "MiniPickPreviewRegion", {link = "nofrils_blue_bg"})

vim.keymap.set("n", "f/", require("mini.pick").registry.registry)
vim.keymap.set("n", "f.", require("mini.pick").registry.resume)
vim.keymap.set("n", "ff", require("mini.pick").registry.files)
vim.keymap.set("n", "fn", require("mini.pick").registry.buffers)
vim.keymap.set("n", "fh", require("mini.pick").registry.help)

vim.keymap.set(
	"n",
	"fm",
	function()
		require("mini.pick").start({
			source = {
				items = require("modal_execution").list_names(),
				choose = function(item)
					if item == nil then return end
					require("modal_execution").set_current_mode(item)
				end,
			},
		})
	end
)
