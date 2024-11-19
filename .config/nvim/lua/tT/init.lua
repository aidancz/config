require("tT/tT")

vim.keymap.set({"n", "x", "o"}, "t", function() return tT.map_expr(true) end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "T", function() return tT.map_expr(false) end, {expr = true})
