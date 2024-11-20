return
{
	"aidancz/paramo.nvim",
	dev = true,
	config = function()
		require("paramo").setup({
			para1_backward = "(",
			para1_forward  = ")",
			para2_backward = "<home>",
			para2_forward  = "<end>",
		})
	end,
}
