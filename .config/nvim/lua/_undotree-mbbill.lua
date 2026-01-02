require("mini.deps").add({
	source = "mbbill/undotree",
})

vim.g.undotree_WindowLayout = 4
vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_SplitWidth = math.floor(vim.o.columns / 4)
vim.g.undotree_DiffpanelHeight = math.floor(vim.o.lines / 4)

vim.g.undotree_HelpLine = 0
vim.g.undotree_ShortIndicators = 1

vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_CursorLine = 0

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
