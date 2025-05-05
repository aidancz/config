require("mini.deps").add({
	source = "echasnovski/mini.snippets",
})

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
		-- 	local chunks = require("modexec").list_chunks()
		-- 	for _, i in ipairs(chunks) do
		-- 		i.body = i.code
		-- 		i.prefix = ""
		-- 		i.tag = string.format(
		-- 			"(%s%s)",
		-- 			i.from,
		-- 			i.name and (" " .. i.name) or ""
		-- 		)
		-- 		i.desc = i.tag
		-- 	end
		-- 	return chunks
		-- 	-- it is okay to have extra fields, so we modify the `chunks` table
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
		select = function(snippets, insert, opts)
			insert = insert or require("mini.snippets").default_insert
			opts = opts or {}

			if #snippets == 1 and (opts.insert_single == nil or opts.insert_single == true) then
				insert(snippets[1])
				return
			end

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
		end,
		insert = function(snippet)
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

-- require("nofrils").clear("^MiniSnippets")

require("modexec").add_mode({
	name = "mini.snippets",
	chunks = {
		{
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
			gkey = {"n", "fe"},
		},
	},
})
