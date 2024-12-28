MiniDeps.add({
	source = "saghen/blink.cmp",
	checkout = "v0.8.2",
})

require("blink.cmp").setup({
	sources = {
	},
	keymap = {
		preset = "none",
		["<down>"] = {
			function(cmp)
				cmp.show()
				vim.defer_fn(function()
					cmp.select_next()
				end, 1)
			end,
		},
		["<up>"] = {
			function(cmp)
				cmp.show()
				vim.defer_fn(function()
					cmp.select_prev()
				end, 1)
			end,
		},
		["<left>"] = {
			function(cmp)
				local a = cmp.cancel()
				if a then
					vim.defer_fn(function()
						cmp.show()
					end, 1)
					return true
				else
					return false
				end
			end,
			"fallback",
		},
		["<right>"] = {
			"hide",
			"fallback",
		},
		-- ["<c-g>"] = {
		-- 	"cancel",
		-- 	"fallback",
		-- },
		-- cmdline = {
		-- 	preset = "none",
		-- },
	},
	completion = {
		list = {
			selection = "auto_insert",
			cycle = {
				from_bottom = false,
				from_top = false,
			},
		},
		menu = {
			auto_show = function(ctx)
				if ctx.mode == "cmdline" then
					return true
				end
				return false
			end,
			scrolloff = 0,
			max_height = 8,
			direction_priority = {"s", "n"},
			-- order = ?,
			-- https://github.com/Saghen/blink.cmp/issues/206
		},
		-- ghost_text = {
		-- 	enabled = true,
		-- },
	},
})
