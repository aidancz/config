require("mini.deps").add({
	-- source = "anuvyklack/hydra.nvim", -- no longer maintained, but has better readme
	source = "nvimtools/hydra.nvim",
})

require("hydra").setup({
	color = "pink",
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

-- # built-in

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
	mode = {"n", "x"},
	body = "z",
	heads = {
		{"h", "5zh", {nowait = true}},
		{"l", "5zl", {nowait = true}},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "<c-w>",
	heads = {
		{"-", "<c-w>-", {nowait = true}},
		{"+", "<c-w>+", {nowait = true}},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "<c-w>",
	heads = {
		{"<", "<c-w><", {nowait = true}},
		{">", "<c-w>>", {nowait = true}},
	},
})

require("hydra")({
	body = "m",
	heads = {
		{"T", "gT", {nowait = true}},
		{"t", "gt", {nowait = true}},
	},
})

require("hydra")({
	body = "m",
	heads = {
		{"C", "<cmd>cprevious<cr>", {nowait = true}},
		{"c", "<cmd>cnext<cr>", {nowait = true}},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "g",
	heads = {
		{"e", "ge", {nowait = true}},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "g",
	heads = {
		{"E", "gE", {nowait = true}},
	},
})

-- # luaexec

require("hydra")({
	body = "m",
	heads = {
		{
			"B",
			function()
				require("luaexec").registry.buffer.prev()
			end,
			{
				nowait = true,
			},
		},
		{
			"b",
			function()
				require("luaexec").registry.buffer.next()
			end,
			{
				nowait = true,
			},
		},
	},
})

require("hydra")({
	body = "m",
	heads = {
		{
			"W",
			function()
				require("luaexec").registry.window.prev()
			end,
			{
				nowait = true,
			},
		},
		{
			"w",
			function()
				require("luaexec").registry.window.next()
			end,
			{
				nowait = true,
			},
		},
	},
})

-- # go-up

require("hydra")({
	mode = {"n", "x"},
	body = "f",
	heads = {
		{
			"y",
			function()
				require("luaexec").registry["go-up"]["scroll -1"]()
			end,
			{
				nowait = true,
			},
		},
		{
			"e",
			function()
				require("luaexec").registry["go-up"]["scroll +1"]()
			end,
			{
				nowait = true,
			},
		},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "f",
	heads = {
		{
			"o",
			function()
				require("luaexec").registry["go-up"]["scroll -1/4"]()
			end,
			{
				nowait = true,
			},
		},
		{
			"s",
			function()
				require("luaexec").registry["go-up"]["scroll +1/4"]()
			end,
			{
				nowait = true,
			},
		},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "f",
	heads = {
		{
			"u",
			function()
				require("luaexec").registry["go-up"]["scroll -2/4"]()
			end,
			{
				nowait = true,
			},
		},
		{
			"d",
			function()
				require("luaexec").registry["go-up"]["scroll +2/4"]()
			end,
			{
				nowait = true,
			},
		},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "f",
	heads = {
		{
			"i",
			function()
				require("luaexec").registry["go-up"]["scroll -4/4"]()
			end,
			{
				nowait = true,
			},
		},
		{
			"w",
			function()
				require("luaexec").registry["go-up"]["scroll +4/4"]()
			end,
			{
				nowait = true,
			},
		},
	},
})

-- # paramo

require("hydra")({
	mode = {"n", "x"},
	body = "m",
	heads = {
		{
			"u",
			function()
				return
				require("paramo").expr({
					direction = "prev",
					is = require("para_nonempty").is_head,
				})
			end,
			{
				expr = true,
				nowait = true,
			},
		},
		{
			"d",
			function()
				return
				require("paramo").expr({
					direction = "next",
					is = require("para_nonempty").is_head,
				})
			end,
			{
				expr = true,
				nowait = true,
			},
		},
	},
})
require("hydra")({
	mode = {"n", "x"},
	body = "m",
	heads = {
		{
			"e",
			function()
				return
				require("paramo").expr({
					direction = "next",
					is = require("para_nonempty").is_tail,
				})
			end,
			{
				expr = true,
				nowait = true,
			},
		},
	},
})

require("hydra")({
	mode = {"n", "x"},
	body = "m",
	heads = {
		{
			"o",
			function()
				return
				require("paramo").expr({
					direction = "prev",
					is = require("para_cursor_column").is_head,
				})
			end,
			{
				expr = true,
				nowait = true,
			},
		},
		{
			"s",
			function()
				return
				require("paramo").expr({
					direction = "next",
					is = require("para_cursor_column").is_head,
				})
			end,
			{
				expr = true,
				nowait = true,
			},
		},
	},
})
require("hydra")({
	mode = {"n", "x"},
	body = "m",
	heads = {
		{
			"x",
			function()
				return
				require("paramo").expr({
					direction = "next",
					is = require("para_cursor_column").is_tail,
				})
			end,
			{
				expr = true,
				nowait = true,
			},
		},
	},
})
