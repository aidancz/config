vim.opt.runtimepath:prepend("~/sync_git/go-up.nvim")

-- require("mini.deps").add({
-- 	source = "nullromo/go-up.nvim",
-- })

require("go-up").setup({
})

vim.keymap.set({"n", "x"}, "<plug>(go-up-redraw)", require("go-up").redraw)
vim.keymap.set({"n", "x"}, "<plug>(go-up-align)", require("go-up").align)

vim.keymap.set({"n"}, "zz", require("go-up").centerScreen)
vim.keymap.set({"n"}, "zb", "<cmd>normal! zb<plug>(go-up-redraw)<cr>", {desc = "https://github.com/nullromo/go-up.nvim/issues/9"})

vim.keymap.set({"n", "x"}, "<c-g>", "<cmd>normal! <c-g><plug>(go-up-align)<cr>")

vim.keymap.set({"n", "x"}, "<c-e>", function() return 1                                           .. "<c-d><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-y>", function() return 1                                           .. "<c-u><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-n>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-d><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-p>", function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. "<c-u><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-d>", function() return math.ceil(vim.api.nvim_win_get_height(0)/2) .. "<c-d><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-u>", function() return math.ceil(vim.api.nvim_win_get_height(0)/2) .. "<c-u><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-f>", function() return math.ceil(vim.api.nvim_win_get_height(0)/1) .. "<c-d><plug>(go-up-align)" end, {expr = true})
vim.keymap.set({"n", "x"}, "<c-b>", function() return math.ceil(vim.api.nvim_win_get_height(0)/1) .. "<c-u><plug>(go-up-align)" end, {expr = true})
-- https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim
