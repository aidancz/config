vim.pack.add({
	"https://github.com/nvim-mini/mini.snippets",
})

-- # require("mini.snippets").default_select -> select_minipick

--[[{{{

---@param local_opts {
---	snippets: table,
---	insert: function,
---}
require("mini.pick").registry.snippets = function(local_opts)
	local snippets = local_opts.snippets
	local insert = local_opts.insert

	for _, i in ipairs(snippets) do
		i.text = string.format(
			"%-16s %-32s %s",
			i.prefix,
			i.desc or i.description,
			i.body
		)
	end

	require("mini.pick").start({
		source = {
			items = snippets,
			choose = function(item)
				vim.schedule(function()
					insert(item)
				end)
			end,
			preview = function(buf_id, item)
				local lines = {}

				local split = function(s)
					if s == nil or s == "" then
						return {""}
					else
						return vim.split(s, "\n", {trimempty = true})
					end
				end
				vim.list_extend(lines, split(item.prefix))
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, split(item.desc or item.description))
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, split(item.body))

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
			end,
		},
	})
end

local select_minipick = function(snippets, insert, opts)
	insert = insert or require("mini.snippets").default_insert
	opts = opts or {}

	if #snippets == 1 and (opts.insert_single == nil or opts.insert_single == true) then
		insert(snippets[1])
		return
	end

	require("mini.pick").registry.snippets({
		snippets = snippets,
		insert = insert,
	})
end

--}}}]]

-- # require("mini.snippets").default_select -> select_fzflua

--{{{

require("fzf-lua").custom_snippets = function(snippets, insert, opts)
	opts = opts or {}

	local snippets_idx = 0
	local contents = vim.tbl_map(
		function(x)
			snippets_idx = snippets_idx + 1
			return
			string.format(
				"%s%s%-16s%s%-32s%s%s",
				snippets_idx,
				require("fzf-lua").utils.nbsp,
				x.prefix,
				require("fzf-lua").utils.nbsp,
				x.desc or x.description,
				require("fzf-lua").utils.nbsp,
				x.body
			)
		end,
		snippets
	)

	local previewer = require("fzf-lua.previewer.builtin").base:extend()
	-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
	previewer.new = function(self, o, opts, fzf_win)
		previewer.super.new(self, o, opts, fzf_win)
		setmetatable(self, previewer)
		return self
	end
	previewer.populate_preview_buf = function(self, entry_str)
		local components = vim.split(entry_str, require("fzf-lua").utils.nbsp)
		local lines = {}
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[2]))
		vim.list_extend(lines, {""})
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[3]))
		vim.list_extend(lines, {""})
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[4]))

		local tmpbuf = self:get_tmp_buffer()
		vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, true, lines)
		self:set_preview_buf(tmpbuf)
		self.win:update_preview_scrollbar()
	end
	previewer.gen_winopts = function(self)
		return
		vim.tbl_extend(
			"force",
			self.winopts,
			require("fzf-lua").form_feed_options_hack
		)
	end

	opts = vim.tbl_deep_extend(
		"force",
		{
			fzf_opts = {
				["--delimiter"] = string.format("[%s]", require("fzf-lua").utils.nbsp),
				["--with-nth"] = "2..",
				["--read0"] = true,
				["--no-multi-line"] = true,
			},
			actions = {
				["default"] = function(selected, opts)
					local components = vim.split(selected[1], require("fzf-lua").utils.nbsp)
					local snippets_idx = tonumber(components[1])
					insert(snippets[snippets_idx])
				end,
			},
			previewer = previewer,
		},
		opts
	)

	require("fzf-lua").fzf_exec(contents, opts)
end

local select_fzflua = function(snippets, insert, opts)
	insert = insert or require("mini.snippets").default_insert
	opts = opts or {}

	if #snippets == 1 and (opts.insert_single == nil or opts.insert_single == true) then
		insert(snippets[1])
		return
	end

	require("fzf-lua").custom_snippets(snippets, insert)
end

--}}}

-- # setup

require("mini.snippets").setup({
	snippets = {

		{
			prefix = "tis",
			body = "this is snippet",
			desc = "snip",
		},

		-- require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),

		require("mini.snippets").gen_loader.from_runtime("global.{json,lua}"),

		-- function(context)
		-- 	local nodes = require("luaexec").list_nodes()
		-- 	for _, i in ipairs(nodes) do
		-- 		i.body = i.code
		-- 		i.prefix = ""
		-- 		i.tag = string.format(
		-- 			"(%s%s)",
		-- 			i.from,
		-- 			i.name and (" " .. i.name) or ""
		-- 		)
		-- 		i.desc = i.tag
		-- 	end
		-- 	return nodes
		-- 	-- it is okay to have extra fields, so we modify the `nodes` table
		-- 	-- of course we can use `vim.tbl_map` instead
		-- end,

		require("mini.snippets").gen_loader.from_lang(),

	},
	mappings = {
		expand = "<c-d>",
		jump_next = "<c-f>",
		jump_prev = "<c-b>",
		stop = "<c-c>",
	},
	expand = {
		-- select = select_minipick,
		select = select_fzflua,
		insert = function(snippet)
		-- https://github.com/nvim-mini/mini.nvim/issues/1730
			return
			require("mini.snippets").default_insert(
				snippet,
				{
					empty_tabstop = "󰊠",
					empty_tabstop_final = "󰮯",
				}
			)
		end,
	},
})

require("nofrils").clear("^MiniSnippets")

-- # paste snippet in normal mode

--[==[

require("luaexec").add({
	code =
[=[
-- if vim.api.nvim_get_current_line() ~= "" then
-- 	local pos = vim.api.nvim_win_get_cursor(0)
-- 	local row0 = pos[1] - 1
-- 	vim.api.nvim_buf_set_lines(
-- 		0,
-- 		row0 + 1,
-- 		row0 + 1,
-- 		true,
-- 		{""}
-- 	)
-- 	vim.api.nvim_win_set_cursor(0, {pos[1]+1, 0})
-- end
require("mini.snippets").expand({
	match = false,
	-- select = false,
	-- insert = false,
})
while require("mini.snippets").session.get() do
	require("mini.snippets").session.stop()
end
vim.schedule(function()
	local key = vim.api.nvim_replace_termcodes([[<c-\><c-n>^]], true, true, true)
	vim.api.nvim_feedkeys(key, "n", false)
end)
]=],
	from = "mini.snippets",
	keys = {"n", "re"},
})

--]==]

require("luaexec").add({
	code =
[=[
local snippets = require("mini.snippets").expand({
	match = false,
	-- select = false,
	insert = false,
})
local insert = function(snippet)
	local lines = vim.split(snippet.body, "\n", {trimempty = true})
	vim.api.nvim_put(lines, "c", false, true)
end
require("fzf-lua").custom_snippets(snippets, insert)
]=],
	from = "mini.snippets",
	keys = {"n", "sd"},
})
