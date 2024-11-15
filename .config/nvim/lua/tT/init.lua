require("tT/tT")

vim.keymap.set({"n", "x", "o"}, "t", function() return "<cmd>normal " .. tT.fun(true)  .. "<cr>" end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "T", function() return "<cmd>normal " .. tT.fun(false) .. "<cr>" end, {expr = true})
