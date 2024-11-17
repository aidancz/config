return
{
	"chentoast/marks.nvim",
	config = function()
		require("marks").setup({
			default_mappings = true,
			builtin_marks = {"[", "]", "<", ">", "'", '"', "^", ".", "0", "1"},
			cyclic = true,
			force_write_shada = false,
			refresh_interval = 150,
			sign_priority = {lower=11, upper=12, builtin=14, bookmark=13},
			excluded_filetypes = {},
			excluded_buftypes = {},
			bookmark_0 = {
				sign = "⚑",
				virt_text = "",
				annotate = false,
			},
			mappings = {}
		})
		vim.api.nvim_set_hl(0, "MarkSignNumHL", {link = "nofrils-blue"})
	end,
}
