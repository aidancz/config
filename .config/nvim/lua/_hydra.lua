require("mini.deps").add({
	-- source = "anuvyklack/hydra.nvim", -- no longer maintained, but has better readme
	source = "nvimtools/hydra.nvim",
})

require("hydra").setup({
	hint = {
		type = "statusline",
		show_name = false,
	},
})

vim.api.nvim_set_hl(0, "HydraRed",      {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "HydraBlue",     {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "HydraAmaranth", {link = "nofrils_magenta"})
vim.api.nvim_set_hl(0, "HydraTeal",     {link = "nofrils_cyan"})
vim.api.nvim_set_hl(0, "HydraPink",     {link = "nofrils_green"})

require("hydra")({
	name = "scroll horizontal",
	-- hint = [[]],
	-- config = {
	-- 	on_key = function()
	-- 	-- https://github.com/nvimtools/hydra.nvim?tab=readme-ov-file#meta-accessors
	-- 		vim.wo.wrap = false
	-- 	end,
	-- },
	-- mode = "n",
	body = "z",
	heads = {
		{
			"w",
			function()
				vim.wo.wrap = not vim.wo.wrap
			end
		},
		{"h", "5zh"},
		{"l", "5zl"},
	},
})

-- require("hydra")({
-- 	body = "m",
-- 	heads = {
-- 		{"B", "[b", {remap = true}},
-- 		{"b", "]b", {remap = true}},
-- 	},
-- })
