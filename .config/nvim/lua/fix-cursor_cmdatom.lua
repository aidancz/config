vim.api.nvim_create_augroup("fix-cursor", {clear = true})
vim.api.nvim_create_autocmd(
	"CmdAtom",
	{
		group = "fix-cursor",
		callback = function(event)
			if
				event.data.type == "visual"
			then
				vim.api.nvim_win_set_cursor(0, event.data.pos)
			end
		end,
	}
)
