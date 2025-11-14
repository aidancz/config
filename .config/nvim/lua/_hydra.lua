--[[

https://github.com/anuvyklack/hydra.nvim
-- this repo is no longer maintained, but has better readme

https://github.com/nvimtools/hydra.nvim
-- maintained fork

to add hydra:

require("hydra")({
	name = ...,
		-- string
	hint = ...,
		-- string
	config = {
		exit = ...,
			-- boolean, exit or not after executing head
		foreign_keys = ...,
			-- nil (allow and quit) | "run" (allow and continue) | "warn" (disallow and continue)
			-- what to do after executing non-head
		color = ...,
			-- "red" | "pink" | "amaranth" | "blue" | "teal", shortcut for "exit" and "foreign_keys"
			-- chart:
			-- | color    | exit  | foreign_keys |
			-- |----------|-------|--------------|
			-- | red      | false | nil          |
			-- | pink     | false | "run"        |
			-- | amaranth | false | "warn"       |
			-- | blue     | true  | nil          |
			-- | teal     | true  | nil          |
		buffer = ...,
			-- true | number
		invoke_on_body = ...,
			-- boolean
		desc = ...,
			-- string
		on_enter = ...,
			-- function
		on_exit = ...,
			-- function
		on_key = ...,
			-- function
		timeout = ...,
			-- boolean | number
		hint = ...,
			-- false | table
	},
	mode = ...,
		-- string | string[]
	body = ...,
		-- string
	heads = {
		{
			...,
				-- string, lhs
			...,
				-- string | function, rhs
			{
				-- # normal vim.keymap.set opts:
					expr = ...,
					silent = ...,
				-- # hydra specific opts:
					private = ...,
						-- boolean
					exit = ...,
						-- boolean
					exit_before = ...,
						-- boolean
					on_key = ...,
						-- boolean
					desc = ...,
						-- false | string
				-- # NOTE: pink hydra only
					nowait = ...,
					mode = ...,
						--string | string[]
			},
		},
		...
	},
})

the forked version allows setting a "global body config table":

require("hydra").setup(<global body config table>)

but i cannot set a "global head config table", so instead, use a wrapper function:

require("hydra").add

--]]

require("mini.deps").add({
	-- source = "anuvyklack/hydra.nvim",
	source = "nvimtools/hydra.nvim",
})

require("hydra").add = function(opts)
-- a wrapper of require("hydra").<metatable>.__call
	local name = {}
	for _, head in ipairs(opts.heads) do
		table.insert(name, opts.body .. head[1])
	end
	opts.name = table.concat(name, " ")

	local default_config_body = {
		color = "pink",
		on_enter = function()
			vim.cmd("redrawstatus")
		end,
		on_exit = function()
			vim.schedule(function()
				vim.cmd("redrawstatus")
			end)
		end,
		hint = false,
	}
	opts.config = vim.tbl_deep_extend("force", default_config_body, opts.config or {})

	local default_config_head = {
		nowait = true,
	}
	for _, head in ipairs(opts.heads) do
		head[3] = vim.tbl_deep_extend("force", default_config_head, head[3] or {})
	end

	require("hydra")(opts)
end

vim.api.nvim_set_hl(0, "HydraRed",      {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "HydraBlue",     {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "HydraAmaranth", {link = "nofrils_magenta"})
vim.api.nvim_set_hl(0, "HydraTeal",     {link = "nofrils_cyan"})
vim.api.nvim_set_hl(0, "HydraPink",     {link = "nofrils_green"})

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
