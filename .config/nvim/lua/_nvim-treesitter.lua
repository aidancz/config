require("mini.deps").add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_install = function()
			require("mini.deps").later(function()
			vim.cmd("TSUpdate")
			end)
		end,
		post_checkout = function()
			vim.cmd("TSUpdate")
		end,
	},
})

----------------------------------------------------------------

-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#using-an-existing-parser-for-another-filetype

vim.treesitter.language.register("bash",     "zsh")
vim.treesitter.language.register("ini",      "conf")
vim.treesitter.language.register("markdown", "text")

----------------------------------------------------------------

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

----------------------------------------------------------------

require("nvim-treesitter.install").prefer_git = true

----------------------------------------------------------------

-- `:h nvim-treesitter-modules`

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"gitcommit",
		"git_rebase",
	},
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local line = vim.api.nvim_buf_line_count(buf)
			if line > 10000 then
				return true
			else
				return false
			end
		end,
		additional_vim_regex_highlighting = false,
	},
	-- indent = {
	-- 	enable = true,
	-- },
})

vim.api.nvim_set_hl(0, '@comment',          {link = 'nofrils-blue'})
vim.api.nvim_set_hl(0, '@diff.delta',       {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, '@diff.minus',       {link = 'nofrils-red'})
vim.api.nvim_set_hl(0, '@diff.plus',        {link = 'nofrils-green'})
vim.api.nvim_set_hl(0, '@markup.heading.1', {link = 'nofrils-red'})
vim.api.nvim_set_hl(0, '@markup.heading.2', {link = 'nofrils-green'})
vim.api.nvim_set_hl(0, '@markup.heading.3', {link = 'nofrils-yellow'})
vim.api.nvim_set_hl(0, '@markup.heading.4', {link = 'nofrils-blue'})
vim.api.nvim_set_hl(0, '@markup.heading.5', {link = 'nofrils-magenta'})
vim.api.nvim_set_hl(0, '@markup.heading.6', {link = 'nofrils-cyan'})
vim.api.nvim_set_hl(0, '@markup.link',      {link = 'nofrils-cyan'})
vim.api.nvim_set_hl(0, '@markup.raw',       {link = 'nofrils-blue'})
