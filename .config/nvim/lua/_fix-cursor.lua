local wrap = require("fix-cursor").wrap

-- # built-in

wrap("v",     "[vV\22]*:n", true)
wrap("V",     "[vV\22]*:n", true)
wrap("<c-v>", "[vV\22]*:n", true)
wrap("gv",    "[vV\22]*:n", true)

wrap("i", "i*:n", true)
wrap("a", "i*:n", true)
wrap("I", "i*:n", true)
wrap("A", "i*:n", true)

wrap("c", "i*:n", true)

wrap("y", "schedule", true)
wrap(".", "schedule", true)

-- # keymap.lua

wrap("e", "schedule", true)

-- # yanky.nvim

wrap("p", "schedule", true)
wrap("P", "schedule", true)

-- # mini.operators

wrap("<space>e", "schedule", false)
wrap("<space>x", "schedule", false)
wrap("t",        "schedule", false)
wrap("gs",       "schedule", false)

-- # substitute.nvim

wrap("x", "schedule", false)
