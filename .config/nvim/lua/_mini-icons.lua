require("mini.deps").add({
	source = "echasnovski/mini.icons",
})

require("mini.icons").setup({
	-- style = "ascii",
	file = {
		["init.lua"] = {glyph = "󰢱", hl = "MiniIconsAzure"},
		-- https://github.com/echasnovski/mini.nvim/issues/1384
	},
})
