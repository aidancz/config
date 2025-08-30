require("mini.deps").add({
	source = "nvim-mini/mini.icons",
})

require("mini.icons").setup({
	-- style = "ascii",
	file = {
		["init.lua"] = {glyph = "󰢱", hl = "MiniIconsAzure"},
		-- https://github.com/nvim-mini/mini.nvim/issues/1384
	},
})
