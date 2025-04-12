local dir = "~/sync_git"
for name, type in vim.fs.dir(dir) do
	if type == "directory" and string.find(name, "vim") then
		vim.opt.runtimepath:prepend(dir .. "/" .. name)
	end
end

vim.api.nvim_set_hl(0, "MiniDepsChangeAdded",   {link = "nofrils_green"})
vim.api.nvim_set_hl(0, "MiniDepsChangeRemoved", {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "MiniDepsHint",          {})
vim.api.nvim_set_hl(0, "MiniDepsInfo",          {})
vim.api.nvim_set_hl(0, "MiniDepsMsgBreaking",   {})
vim.api.nvim_set_hl(0, "MiniDepsPlaceholder",   {})
vim.api.nvim_set_hl(0, "MiniDepsTitle",         {})
vim.api.nvim_set_hl(0, "MiniDepsTitleError",    {link = "nofrils_red"})
vim.api.nvim_set_hl(0, "MiniDepsTitleSame",     {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "MiniDepsTitleUpdate",   {link = "nofrils_green"})
