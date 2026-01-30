vim.pack.add({
	"https://github.com/gbprod/yanky.nvim",
})

require("yanky").setup({
	highlight = {
		on_put = false,
		on_yank = false,
	},
})

-- vim.keymap.set({"n", "x"}, "y", "<plug>(YankyYank)")

vim.keymap.set({"n", "x"}, "p", "<plug>(YankyPutAfter)")
vim.keymap.set({"n", "x"}, "P", "<plug>(YankyPutBefore)")

require("luaexec").add({
	code = [[require("yanky").cycle(1)]],
	from = "yanky",
	name = "prev",
	keys = {{"n", "x"}, "<pageup>"},
})

require("luaexec").add({
	code = [[require("yanky").cycle(-1)]],
	from = "yanky",
	name = "next",
	keys = {{"n", "x"}, "<pagedown>"},
})

require("luaexec").add({
	code = [[require("yanky.picker").select_in_history()]],
	from = "yanky",
	name = "history",
})

do return end

-- # if yank/delete space chars to the unnamed register, append to the register instead of replace

vim.api.nvim_create_augroup("yank_space_chars", {clear = true})
vim.api.nvim_create_autocmd(
	"TextYankPost",
	{
		group = "yank_space_chars",
		callback = function()
			local ev = vim.v.event
			-- vim.print(ev); do return end;

			if ev.regname ~= "" then return end -- ensure unnamed register
			if string.find(ev.regtype, vim.keycode("<c-v>")) then return end

			local regcontent = table.concat(ev.regcontents, "\n")
			if ev.regtype == "V" then regcontent = regcontent .. "\n" end
			local space_chars = string.match(regcontent, "^%s+$")
			if space_chars == nil then return end

			local reg = require("yanky.history").storage.get(2).regcontents
			reg = reg .. space_chars
			vim.fn.setreg("", reg)
			vim.fn.setreg("+", reg)
			vim.fn.setreg("*", reg)
		end,
	}
)
