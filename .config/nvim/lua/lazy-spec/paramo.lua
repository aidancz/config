return
{
	"aidancz/paramo.nvim",
	dev = true,
	config = function()
		require("paramo").setup({
			-- {
			-- 	type = "para0",
			-- 	backward = "{",
			-- 	forward = "}",
			-- },
			{
				type = "para1",
				screen_or_logical_column = "screen",
				backward = "(",
				forward = ")",
			},
			{
				type = "para2",
				screen_or_logical_column = "screen",
				backward = "<home>",
				forward = "<end>",
			},
		})
	end,
}
