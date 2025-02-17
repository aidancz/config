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

require("blink.cmp").setup({
	sources = {
	},
	keymap = {
		preset = "none",
		["<down>"] = {
			function(cmp)
				cmp.show({
					callback = function()
						cmp.select_next()
					end,
				})
				cmp.select_next()
			end,
		},
		["<up>"] = {
			function(cmp)
				cmp.show({
					callback = function()
						cmp.select_prev()
					end,
				})
				cmp.select_prev()
			end,
		},
		-- ["<left>"] = {
		-- 	function(cmp)
		-- 		return cmp.cancel({
		-- 			callback = function()
		-- 				cmp.show()
		-- 			end,
		-- 		})
		-- 	end,
		-- 	"fallback",
		-- },
		-- ["<right>"] = {
		-- 	"hide",
		-- 	"fallback",
		-- },
		-- ["<c-g>"] = {
		-- 	"cancel",
		-- 	"fallback",
		-- },
	},
	cmdline = {
		keymap = {
			preset = "none",
			["<tab>"] = {
				"select_next",
			},
			["<s-tab>"] = {
				"select_prev",
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
			border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
			auto_show = function(ctx)
				if ctx.mode == "cmdline" then
					return true
				end
				return false
			end,
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
})
