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
		function(context)
			return
			vim.tbl_map(
				function(x)
					local tag = string.format(
						"(%s%s)",
						x.from,
						x.name and (" " .. x.name) or ""
					)
					local code = x.code
					local desc = string.format(
						"%-31s\n%s",
						tag,
						code
					)
					return
					{
						body = x.code,
						desc = desc,
					}
				end,
				require("modexec").list_chunks()
			)
		end,
		require("mini.snippets").gen_loader.from_lang(),
	},
	mappings = {
		expand = "<c-d>",
		jump_next = "<c-f>",
		jump_prev = "<c-b>",
		stop = "<c-c>",
	},
	expand = {
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
if vim.api.nvim_get_current_line() ~= "" then
	local pos = vim.api.nvim_win_get_cursor(0)
	local row0 = pos[1] - 1
	vim.api.nvim_buf_set_lines(
		0,
		row0 + 1,
		row0 + 1,
		true,
		{""}
	)
	vim.api.nvim_win_set_cursor(0, {pos[1]+1, 0})
end
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
