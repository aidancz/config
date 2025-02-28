vim.go.statusline = "%{%v:lua.Statusline.str()%}"

Statusline = {}

Statusline.str = function()
	if vim.o.laststatus == 3 then
		return Statusline.str_active()
	end

	if vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin) then
		return Statusline.str_active()
	else
		return Statusline.str_inactive()
	end
end

Statusline.str_active = function()
	local list = {
		"%t",
		"%S",
		"%<",
		"%=",
		Statusline.nvim_recorder(),
		"(" .. math.max(1, vim.fn.col(".")) .. " " .. vim.fn.col("$") .. ")",
		"(%l %L)",
	}
	return table.concat(list, " ")
end

Statusline.str_inactive = function()
	local list = {
		"%t",
	}
	return table.concat(list, " ")
end



Statusline.nvim_recorder = function()
	if package.loaded["recorder"] then
		return package.loaded["recorder"].displaySlots()
	else
		return ""
	end
end
