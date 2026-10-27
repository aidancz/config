local wrap = require("fix-cursor").wrap

-- # built-in

wrap("v",     "*:n")
wrap("V",     "*:n")
wrap("<c-v>", "*:n")
wrap("gv",    "*:n")

wrap("i", "*:n")
wrap("a", "*:n")
wrap("I", "*:n")
wrap("A", "*:n")

wrap("c", "*:n")
wrap("y", "*:n")

wrap(".", "*:n")

-- # keymap.lua

wrap("e", "*:n")

wrap("<bs>",  "schedule")
wrap("<del>", "schedule")

-- # yanky.nvim

wrap("p", "schedule")
wrap("P", "schedule")

-- # mini.operators

wrap("<space>e", "*:n")
wrap("<space>x", "*:n")
wrap("t",        "*:n")
wrap("gs",       "*:n")

-- # substitute.nvim

wrap("x", "*:n")
