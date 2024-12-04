MiniDeps.add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_checkout = function()
			vim.cmd("TSUpdate")
		end,
	},
})

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

pcall(function() vim.treesitter.query.set("scheme",          "highlights", "(comment) @comment") end)
pcall(function() vim.treesitter.query.set("c",               "highlights", "(comment) @comment") end)
pcall(function() vim.treesitter.query.set("java",            "highlights", "")                   end)
pcall(function() vim.treesitter.query.set("python",          "highlights", "(comment) @comment") end)
pcall(function() vim.treesitter.query.set("javascript",      "highlights", "(comment) @comment") end)
pcall(function() vim.treesitter.query.set("markdown",        "highlights", "")                   end)
pcall(function() vim.treesitter.query.set("markdown_inline", "highlights", "")                   end)
pcall(function() vim.treesitter.query.set("lua",             "highlights", "(comment) @comment") end)
pcall(function() vim.treesitter.query.set("css",             "highlights", "(comment) @comment") end)
-- use `pcall` here because there is an error if a certain parser is not available

vim.treesitter.language.register("bash", "zsh")
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#using-an-existing-parser-for-another-filetype
vim.treesitter.language.register("ini", "conf")
