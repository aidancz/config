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

-- # window scroll

require("hydra")({
	name = "scroll horizontally",
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
		{"h", "5zh"},
		{"l", "5zl"},
	},
})

require("hydra")({
	body = "f",
	heads = {
		{
			"y",
			function()
				require("luaexec").registry["go-up"]["scroll -1"]()
			end,
		},
		{
			"e",
			function()
				require("luaexec").registry["go-up"]["scroll +1"]()
			end,
		},
	},
})

require("hydra")({
	body = "f",
	heads = {
		{
			"o",
			function()
				require("luaexec").registry["go-up"]["scroll -1/4"]()
			end,
		},
		{
			"s",
			function()
				require("luaexec").registry["go-up"]["scroll +1/4"]()
			end,
		},
	},
})

require("hydra")({
	body = "f",
	heads = {
		{
			"u",
			function()
				require("luaexec").registry["go-up"]["scroll -2/4"]()
			end,
		},
		{
			"d",
			function()
				require("luaexec").registry["go-up"]["scroll +2/4"]()
			end,
		},
	},
})

require("hydra")({
	body = "f",
	heads = {
		{
			"i",
			function()
				require("luaexec").registry["go-up"]["scroll -4/4"]()
			end,
		},
		{
			"w",
			function()
				require("luaexec").registry["go-up"]["scroll +4/4"]()
			end,
		},
	},
})

-- # window resize

require("hydra")({
	body = "<c-w>",
	heads = {
		{"-", "<c-w>-"},
		{"+", "<c-w>+"},
	},
})

require("hydra")({
	body = "<c-w>",
	heads = {
		{"<", "<c-w><"},
		{">", "<c-w>>"},
	},
})

-- # prev & next

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

require("hydra")({
	body = "m",
	heads = {
		{"C", "<cmd>cprevious<cr>"},
		{"c", "<cmd>cnext<cr>"},
	},
})
