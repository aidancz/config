require("mini.deps").add({
	source = "chrisgrieser/nvim-recorder",
})

require("recorder").setup({
	-- lessNotifications = true,
	useNerdfontIcons = false,
})

vim.keymap.set("n", "<a-q>", "Q<c-q>", {remap = true})
