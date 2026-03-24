vim.pack.add({
	"https://github.com/nvim-mini/mini.comment",
	"https://github.com/folke/ts-comments.nvim",
})

local filetype = {
	texinfo = "@c %s",
}

require("ts-comments").setup({
	lang = {
	-- NOTE: <treesitter lang> -> <cms>, not <filetype> -> <cms>
		bash = "# %s",
		lua = "-- %s",
		scheme = { ";; %s", "; %s" },
	},
})

require("mini.comment").setup({
	options = {
		custom_commentstring = function(ref_position)
			local cms

			cms = vim.bo.cms
			if cms ~= "" then return cms end

			cms = filetype[vim.bo.ft]
			if cms ~= nil then return cms end

			cms = require("mini.comment").get_commentstring(ref_position)
			if cms ~= "" then return cms end

			return "? %s"
		end,
	},
	mappings = {
		comment = "<space>c",
		comment_line = "",
		comment_visual = "<space>c",
		textobject = "ac",
	},
})
