require("mini.deps").add({
	source = "saghen/blink.cmp",
	-- checkout = "main",
	hooks = {
		post_install = function(arg)
			vim.system({"cargo", "build", "--release"}, {cwd = arg.path}):wait()
		end,
		post_checkout = function(arg)
			vim.system({"cargo", "build", "--release"}, {cwd = arg.path}):wait()
		end,
	},
})

local config =
{
	sources = {
		providers = {
			lsp = {
			},
		},
	},
	keymap = {
		preset = "none",
		["<down>"] = {
			"show_and_insert",
			"select_next",
		},
		["<up>"] = {
			"show_and_insert",
			"select_prev",
		},
		["<pagedown>"] = {
			"hide",
		},
		-- ["<pageup>"] = {
		-- 	"cancel",
		-- },
		["<pageup>"] = {
			function(cmp)
				return cmp.cancel({
					callback = function()
						cmp.show()
					end,
				})
			end,
		},
	},
	cmdline = {
		keymap = {
			preset = "none",
			["<tab>"] = {
				"show_and_insert",
				"select_next",
			},
			["<s-tab>"] = {
				"show_and_insert",
				"select_prev",
			},
		},
		completion = {
			list = {
				selection = {
					auto_insert = true,
					preselect = false,
				},
			},
			menu = {
				auto_show = true,
			},
		},
	},
	completion = {
		list = {
			selection = {
				auto_insert = true,
				preselect = false,
			},
			cycle = {
				from_bottom = false,
				from_top = false,
			},
		},
		menu = {
			auto_show = false,
			scrolloff = 0,
			min_width = 32,
			max_height = 16,
			direction_priority = {"s", "n"},
			-- order = ?,
			-- https://github.com/Saghen/blink.cmp/issues/206
		},
		-- ghost_text = {
		-- 	enabled = true,
		-- },
	},
	fuzzy = {
		implementation = "rust",
	},
}
-- config.cmdline.keymap = config.keymap
require("blink.cmp").setup(config)
