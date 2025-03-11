require("mini.deps").add({
	source = "kevinhwang91/nvim-fundo",
	depends = {
		{
			source = "kevinhwang91/promise-async",
		},
	},
	hooks = {
		post_install = function()
			require("mini.deps").later(function()
			require("fundo").install()
			end)
		end,
		post_checkout = function()
			require("fundo").install()
		end,
	},
})

vim.o.undofile = true
require("fundo").setup()
