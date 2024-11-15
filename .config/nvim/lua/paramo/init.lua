local para1 = require("paramo/para1")
local para2 = require("paramo/para2")



-- # para1

vim.keymap.set({"n", "v"}, "(", para1.backward)
vim.keymap.set({"n", "v"}, ")", para1.forward)
vim.keymap.set("o", "(", function() return ":normal V" .. vim.v.count1 .. "(<cr>" end, {silent = true, expr = true})
vim.keymap.set("o", ")", function() return ":normal V" .. vim.v.count1 .. ")<cr>" end, {silent = true, expr = true})
-- https://vi.stackexchange.com/questions/6101/is-there-a-text-object-for-current-line/6102#6102



-- # para2

vim.keymap.set({"n", "v"}, "<home>",   para2.backward)
vim.keymap.set({"n", "v"}, "<end>", para2.forward)

vim.keymap.set("o", "<home>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<home>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})

vim.keymap.set("o", "<end>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<end>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})



vim.keymap.set({"n", "v"}, "<pageup>",   para2.backward_special)
vim.keymap.set({"n", "v"}, "<pagedown>", para2.forward_special)

vim.keymap.set("o", "<pageup>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<pageup>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})

vim.keymap.set("o", "<pagedown>",
	function()
		return [[:exe "normal V]] .. vim.v.count1 .. [[\<pagedown>"]] .. vim.api.nvim_replace_termcodes([[<cr>]], true, true, true)
	end,
	{silent = true, expr = true, replace_keycodes = false})
