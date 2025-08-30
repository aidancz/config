require("mini.deps").add({
	source = "nvim-mini/mini.statusline",
})

require("mini.statusline").setup({
	-- content = {
	-- 	active = function()
	-- 		local M = MiniStatusline
	-- 		local max_width = vim.o.columns
	-- 		local min_width = 1
	--
	-- 		local groups = {
	-- 			{
	-- 				strings = {
	-- 					M.section_filename({trunc_width = max_width}),
	-- 				},
	-- 			},
	-- 		}
	--
	-- 		return M.combine_groups(groups)
	-- 	end,
	-- },
})
