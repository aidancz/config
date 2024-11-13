emc = {}

emc.fun = function(direction)
	emc.direction = direction
	vim.go.operatorfunc = "v:lua.emc.fun_callback"
	return "g@l"
end

emc.fun_callback = function()
	vim.api.nvim_put({string.rep(" ", vim.v.count1)}, "c", emc.direction, true)
	if emc.direction then
		vim.api.nvim_feedkeys("h", "n", false)
	else
		vim.api.nvim_feedkeys(vim.v.count1 .. "h", "n", false)
	end
end
