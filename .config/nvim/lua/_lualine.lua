require("mini.deps").add({
	source = "nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	sections = {
		lualine_y = {
			{require("recorder").displaySlots},
		},
		lualine_z = {
			{require("recorder").recordingStatus},
		},
	},
})
