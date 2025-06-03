require("mini.deps").add({
	-- source = "anuvyklack/hydra.nvim", -- no longer maintained, but has better readme
	source = "nvimtools/hydra.nvim",
})

require("hydra").setup({
	hint = false,
	on_enter = function()
		vim.cmd("redrawstatus")
	end,
	on_exit = function()
		vim.schedule(function()
			vim.cmd("redrawstatus")
		end)
	end,
})

vim.api.nvim_set_hl(0, "HydraRed",      {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "HydraBlue",     {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "HydraAmaranth", {link = "nofrils_magenta"})
vim.api.nvim_set_hl(0, "HydraTeal",     {link = "nofrils_cyan"})
vim.api.nvim_set_hl(0, "HydraPink",     {link = "nofrils_green"})

require("hydra")({
	name = "scroll horizontal",
	hint = nil,
	config = {
		-- color = "amaranth",
		-- on_enter = function()
		-- -- https://github.com/nvimtools/hydra.nvim?tab=readme-ov-file#meta-accessors
		-- 	vim.wo.wrap = false
		-- end,
	},
	mode = "n",
	body = "z",
	heads = {
		{
			"w",
			function()
				vim.wo.wrap = not vim.wo.wrap
			end
		},
		{"h", "5zh"},
		{"l", "5zl"},
	},
})

require("hydra")({
	config = {
		on_key = function()
			vim.wait(0) -- https://github.com/anuvyklack/hydra.nvim/issues/36
		end,
	},
	body = "m",
	heads = {
		{
			"B",
			function()
				require("luaexec").registry.buffer.prev()
			end,
		},
		{
			"b",
			function()
				require("luaexec").registry.buffer.next()
			end,
		},
	},
})

require("hydra")({
	config = {
		on_key = function()
			vim.wait(0) -- https://github.com/anuvyklack/hydra.nvim/issues/36
		end,
	},
	body = "m",
	heads = {
		{
			"W",
			function()
				require("luaexec").registry.window.prev()
			end,
		},
		{
			"w",
			function()
				require("luaexec").registry.window.next()
			end,
		},
	},
})

require("hydra")({
	config = {
		on_key = function()
			vim.wait(0) -- https://github.com/anuvyklack/hydra.nvim/issues/36
		end,
	},
	body = "m",
	heads = {
		{"T", "gT"},
		{"t", "gt"},
	},
})
