vim.opt.runtimepath:prepend("~/sync_git/eolmark.nvim")

-- require("mini.deps").add({
-- 	source = "aidancz/eolmark.nvim",
-- })

require("eolmark").setup({
	excluded_filetypes = {
	},
	excluded_buftypes = {
		".+",
	},
	opts = {
		virt_text = {{"󰮯", "nofrils-white"}},
		-- 󰊠󰮯
		-- virt_text_pos = "inline",
		-- hl_mode = "combine",
		-- priority = 10000,
	},
})
