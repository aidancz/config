-- 2025-09-24
-- error: invalid node type
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/3092
-- delete /usr/local/lib/nvim

-- 2026-01-31
-- highlight does not work
-- delete /home/aidan/.local/share/nvim/site/parser
-- delete /home/aidan/.local/share/nvim/site/parser-info
-- delete /home/aidan/.local/share/nvim/site/queries

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		data = {
			on_packchanged = function(ev)
				local kind = ev.data.kind
				local kinds = {"install", "update"}
				if not vim.list_contains(kinds, kind) then return end
				local active = ev.data.active
				if not active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
			end,
		},
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
	"diff",
	"git_rebase",
	"gitcommit",
	"ini",
	"lua",
	"markdown",
	"markdown_inline",
	"toml",
	"vim",
	"xml",
	"xresources",

}

require("nvim-treesitter").install(parsers)

-- ## parser -> filetype/filetypes

vim.treesitter.language.register("bash", {
	"sh",
	"csh",
	"zsh",
})
vim.treesitter.language.register("ini", "conf")
vim.treesitter.language.register("markdown", "text")
vim.treesitter.language.register("scheme", "lisp")

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
