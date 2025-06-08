require("mini.deps").add({
	source = "stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = {
			"stylua",
		},
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("luaexec").add({
	code = [[require("conform").format()]],
	from = "conform",
})
