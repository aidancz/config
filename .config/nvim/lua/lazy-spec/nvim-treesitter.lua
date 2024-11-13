return
{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = {},
			auto_install = true,
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false,
			},
			-- indent = {
			-- 	enable = true,
			-- },
		})

		vim.treesitter.query.set("scheme",          "highlights", "(comment) @comment")
		vim.treesitter.query.set("c",               "highlights", "(comment) @comment")
		-- vim.treesitter.query.set("java",            "highlights", "")
		vim.treesitter.query.set("python",          "highlights", "(comment) @comment")
		vim.treesitter.query.set("javascript",      "highlights", "(comment) @comment")
		-- vim.treesitter.query.set("markdown",        "highlights", "")
		vim.treesitter.query.set("markdown_inline", "highlights", "")
		vim.treesitter.query.set("lua",             "highlights", "(comment) @comment")
		vim.treesitter.query.set("css",             "highlights", "(comment) @comment")

		vim.treesitter.language.register("bash", "zsh")
		-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#using-an-existing-parser-for-another-filetype
		vim.treesitter.language.register("ini", "conf")
	end,
}
