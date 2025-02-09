require("mini.deps").add({
	source = "hedyhli/outline.nvim",
	depends = {
		{
			source = "epheien/outline-treesitter-provider.nvim",
		},
	},
})

require("outline").setup({
	outline_window = {
		position = "left",
		width = math.ceil(vim.o.columns / 8),
		relative_width = false,
		jump_highlight_duration = false,
		show_cursorline = true,
	},
	outline_items = {
		-- show_symbol_lineno = true,
		highlight_hovered_item = false,
		auto_set_cursor = true,
	},
	guides = {
		enabled = false,
	},
	symbol_folding = {
		autofold_depth = false,
		markers = {"●", "○"},
	},
	keymaps = {
		show_help        = {"<c-h>"},
		close            = {},
		goto_location    = {"o"},
		peek_location    = {"i"},
		goto_and_close   = {},
		restore_location = {"r"},
		hover_symbol     = {},
		toggle_preview   = {},
		rename_symbol    = {},
		code_actions     = {},
		fold             = {"zc"},
		unfold           = {"zo"},
		fold_toggle      = {"za"},
		fold_toggle_all  = {},
		fold_all         = {"zm"},
		unfold_all       = {"zr"},
		fold_reset       = {"zx"},
		down_and_jump    = {},
		up_and_jump      = {},
	},
	providers = {
		priority = {
			"lsp",
			-- "markdown",
			"treesitter",
		},
		markdown = {
			filetypes = {
				"text",
			},
		},
	},
	symbols = {
		icon_fetcher = function() return "" end,
		icon_source = nil,
		icons = nil,
	},
})

-- pcall(function()
-- require("nofrils").clear({"^Outline"})
-- end)
-- vim.api.nvim_set_hl(0, "OutlineCurrent", {link = "nofrils-red-bg"})

vim.keymap.set("n", "<f10>", "<cmd>Outline<cr>")

local outline_augroup = vim.api.nvim_create_augroup("outline", {clear = true})
vim.api.nvim_create_autocmd(
	"VimEnter",
	{
		group = outline_augroup,
		command = "OutlineOpen!",
	})
