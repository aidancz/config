require("eolmark").setup({
	excluded_filetypes = {
	},
	excluded_buftypes = {
		".+",
	},
	opts = {
		virt_text = {{"󰮯", "nofrils_white"}},
		-- 󰊠󰮯
		-- virt_text_pos = "inline",
		-- hl_mode = "combine",
		-- priority = 10000,
	},
})
