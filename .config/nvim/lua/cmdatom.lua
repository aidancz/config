-- # repeat motion

local motion_data

local lhs = ";"

vim.api.nvim_create_autocmd(
	"CmdAtom",
	{
		callback = function(event)
			local is_motion = event.data.type == "motion"
			local moved_and_not_changed = event.data.moved and (not event.data.changed)
			local is_lhs = event.data.lhs == lhs
			if (is_motion or moved_and_not_changed) and (not is_lhs) then
				motion_data = event.data
			end
		end,
	}
)

vim.keymap.set(
	{"n", "x"},
	lhs,
	vim.schedule_wrap(function()
		if motion_data == nil then return end
		vim.api.nvim_feedkeys(motion_data.lhs, "m", "false")
	end)
)
