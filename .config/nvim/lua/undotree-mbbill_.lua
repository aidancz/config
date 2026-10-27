vim.pack.add({
	"https://github.com/mbbill/undotree",
})

-- vim.opt.runtimepath:prepend("~/sync_git/undotree.vim"); vim.cmd("runtime plugin/undotree.vim")

vim.g.undotree_WindowLayout = 1
vim.g.undotree_DiffAutoOpen = 1
vim.g.undotree_SplitWidth = math.floor(vim.o.columns / 4)
vim.g.undotree_DiffpanelHeight = math.floor(vim.o.lines / 3)

vim.g.undotree_HelpLine = 1
vim.g.undotree_ShortIndicators = 0
vim.g.undotree_CursorLine = 0

vim.g.undotree_DiffCommand = "git diff"

vim.g.undotree_SetFocusWhenToggle = 1

require("luaexec").add({
	code = [[vim.cmd.UndotreeToggle()]],
	from = "undotree",
	name = "window",
})

vim.api.nvim_create_augroup("undotree_config", {clear = true})
vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "undotree_config",
		pattern = "undotree",
		callback = function()
			vim.wo.signcolumn = "no"
		end,
	}
)
