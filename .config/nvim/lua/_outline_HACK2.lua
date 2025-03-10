-- outline.nvim is not compatible with `set cpoptions+=u`
-- use this hack to simulate it

local M = {}

M.undo_redo = "redo"

M.undo_redo_toggle = function()
	if M.undo_redo == "undo" then
		M.undo_redo = "redo"
	else
		M.undo_redo = "undo"
	end
end

M.undo_redo_do = function()
	vim.cmd(M.undo_redo)
end

vim.api.nvim_create_augroup("undo_redo", {clear = true})
M.create_autocmd = function()
	vim.api.nvim_create_autocmd(
		"TextChanged",
		{
			group = "undo_redo",
			callback = function()
				M.undo_redo = "redo"
			end,
			once = true,
		}
	)
end
M.delete_autocmd = function()
	vim.api.nvim_clear_autocmds({group = "undo_redo"})
end

----------------------------------------------------------------

vim.keymap.set("n", "u", function()
		M.delete_autocmd()
		M.undo_redo_toggle()
		M.undo_redo_do()
		vim.schedule(function()
			M.create_autocmd()
		end)
	end)

vim.keymap.set("n", "<c-r>", function()
		M.delete_autocmd()
		M.undo_redo_do()
		vim.schedule(function()
			M.create_autocmd()
		end)
	end)
