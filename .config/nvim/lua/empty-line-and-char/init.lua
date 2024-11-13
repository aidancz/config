require("empty-line-and-char/eml")
require("empty-line-and-char/emc")

vim.keymap.set("n", "<down>",  function() return eml.fun(true)  end, {expr = true})
vim.keymap.set("n", "<up>",    function() return eml.fun(false) end, {expr = true})
vim.keymap.set("n", "<right>", function() return emc.fun(true)  end, {expr = true})
vim.keymap.set("n", "<left>",  function() return emc.fun(false) end, {expr = true})
