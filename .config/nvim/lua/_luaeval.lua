require("luaeval").setup({
})

vim.keymap.set("n", "x", require("luaeval").toggle)
