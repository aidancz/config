require("mini.deps").add({
	source = "stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = {
			"stylua",
		},
		go = {
			"gofumpt",
			-- https://github.com/jesseduffield/lazygit/blob/master/CONTRIBUTING.md#code-formatting
		},
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("luaexec").add({
	code = [[require("conform").format()]],
	from = "conform",
})
