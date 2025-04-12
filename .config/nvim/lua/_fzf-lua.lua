-- https://github.com/ibhagwan/fzf-lua/issues/140

require("mini.deps").add({
	source = "ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	winopts = {
		border = "bold",
		backdrop = 100,
		preview = {
			border = "bold",
			winopts = {
				number = false,
			},
		},
	},
	keymap = {
		builtin = {
			true,
		},
		fzf = {
			true,
			["ctrl-a"] = "first",
			["ctrl-e"] = "last",
		},
	},
})

require("nofrils").clear("^FzfLua")

vim.api.nvim_set_hl(0, "FzfLuaCursorLine", {link = "nofrils_reverse"})

-------------
do return end
-------------

vim.keymap.set("n", "f/", require("fzf-lua").builtin)
vim.keymap.set("n", "f.", require("fzf-lua").resume)
vim.keymap.set("n", "ff", require("fzf-lua").files)
vim.keymap.set("n", "fn", require("fzf-lua").buffers)
vim.keymap.set("n", "fh", require("fzf-lua").helptags)

vim.keymap.set(
	"n",
	"fm",
	function()
		require("fzf-lua").fzf_exec(
			require("modal_execution").list_names(),
			{
				actions = {
					default = function(selected, opts)
						require("modal_execution").set_current_mode(selected[1])
					end,
				},
			}
		)
	end
)
