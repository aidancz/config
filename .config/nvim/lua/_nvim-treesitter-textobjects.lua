vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
	},
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@code_block.inner"] = "V",
			["@code_block.outer"] = "V",
		},
		include_surrounding_whitespace = function(opts)
			if
				opts.query_string == "@parameter.outer"
			then
				return true
			else
				return false
			end
		end
	},
})

-- # select

do return end

-- ## builtin capture

vim.keymap.set(
	{"x", "o"},
	"ia",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@parameter.inner",
			"textobjects"
		)
	end
)

vim.keymap.set(
	{"x", "o"},
	"aa",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@parameter.outer",
			"textobjects"
		)
	end
)

vim.keymap.set(
	{"x", "o"},
	"if",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@call.inner",
			"textobjects"
		)
	end
)

vim.keymap.set(
	{"x", "o"},
	"af",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@call.outer",
			"textobjects"
		)
	end
)

-- ## custom capture

vim.keymap.set(
	{"x", "o"},
	"ic",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@code_block.inner",
			"textobjects"
		)
	end
)

vim.keymap.set(
	{"x", "o"},
	"ac",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@code_block.outer",
			"textobjects"
		)
	end
)

vim.keymap.set(
	{"x", "o"},
	"iF",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@call.name",
			"textobjects"
		)
	end
)

vim.keymap.set(
	{"x", "o"},
	"aF",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@call.name",
			"textobjects"
		)
	end
)
