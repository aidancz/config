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
				backward = "(",
				forward = ")",
				screen_or_logical_column = "screen",
			},
			{
				type = "para2",
				backward = "<home>",
				forward = "<end>",
				screen_or_logical_column = "screen",
			},
		})
	end,
}
