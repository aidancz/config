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

vim.keymap.set("n", "fu", vim.cmd.UndotreeToggle)

vim.api.nvim_create_autocmd(
	"FileType",
	{
		group = "filetype",
		pattern = "undotree",
		callback = function()
			vim.opt_local.signcolumn = "no"
		end,
	}
)
