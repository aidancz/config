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
