require("mini.deps").add({
	source = "echasnovski/mini.bracketed",
})

require("mini.bracketed").setup({
	jump     = {suffix = "g", options = {}},
	location = {suffix = "a", options = {}},
})

for _, i in pairs(require("mini.bracketed").config) do
	vim.keymap.set("n", string.format("<a-%s>",   i.suffix), string.format("]%s", i.suffix), {remap = true})
	vim.keymap.set("n", string.format("<a-s-%s>", i.suffix), string.format("[%s", i.suffix), {remap = true})
end
