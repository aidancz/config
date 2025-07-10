require("mini.deps").add({
	source = "nvim-treesitter/nvim-treesitter",
	checkout = "main",
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

-- # parser

-- ## install

local parsers = {

	"scheme",
	"c",
	"java",
	"python",
	"javascript",

	"bash",
	"cpp",
	"css",
	"git_rebase",
	"gitcommit",
	"lua",
	"markdown",
	"markdown_inline",

}

require("nvim-treesitter").install(parsers)

-- ## parser -> filetype

vim.treesitter.language.register("bash",     "zsh")
vim.treesitter.language.register("ini",      "conf")
vim.treesitter.language.register("markdown", "text")
vim.treesitter.language.register("scheme",   "lisp")

-- # highlights

-- ## query

-- vim.treesitter.query.set(
-- 	"scheme",
-- 	"highlights",
-- 	"(comment) @comment"
-- )

-- ## treesitter-highlight-groups

vim.api.nvim_set_hl(0, "@comment",          {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "@diff.delta",       {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "@diff.minus",       {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@diff.plus",        {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "@markup.heading.1", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@markup.heading.2", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@markup.heading.3", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@markup.heading.4", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@markup.heading.5", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@markup.heading.6", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "@markup.link",      {link = "nofrils_cyan"})
vim.api.nvim_set_hl(0, "@markup.raw",       {link = "nofrils_blue"})

-- ## enable

local highlights_enable = function()
	pcall(function()
		vim.treesitter.start()
	end)
end

highlights_enable()

vim.api.nvim_create_autocmd(
	"FileType",
	{
		callback = highlights_enable,
	}
)

-- # indent

vim.keymap.set(
	{"n", "x"},
	"=",
	function()
		local cache_indentexpr = vim.bo.indentexpr
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.api.nvim_create_autocmd(
			"ModeChanged",
			{
				pattern = "*:n",
				callback = function()
					vim.schedule(function()
						vim.bo.indentexpr = cache_indentexpr
					end)
				end,
				once = true,
			}
		)
		return "="
	end,
	{
		expr = true,
	}
)
