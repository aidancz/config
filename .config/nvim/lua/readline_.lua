vim.pack.add({
	"https://github.com/assistcontrol/readline.nvim",
})

vim.keymap.set({"i", "c"}, "<c-f>", "<right>")
vim.keymap.set({"i", "c"}, "<c-b>", "<left>")
vim.keymap.set({"i", "c"}, "<c-n>", "<down>")
vim.keymap.set({"i", "c"}, "<c-p>", "<up>")

vim.keymap.set({"i", "c"}, "<m-f>", require("readline").forward_word)
vim.keymap.set({"i", "c"}, "<m-b>", require("readline").backward_word)

vim.keymap.set({"i", "c"}, "<c-a>", require("readline").beginning_of_line)
vim.keymap.set({"i", "c"}, "<c-e>", require("readline").end_of_line)

vim.keymap.set({"i", "c"}, "<c-k>", require("readline").kill_line)
