eml = {}

eml.fun = function(direction)
	eml.direction = direction
	vim.go.operatorfunc = "v:lua.eml.fun_callback"
	return "g@l"
end

eml.fun_callback = function()
	local lnum_current = vim.fn.line(".")
	vim.fn.append((eml.direction and lnum_current or lnum_current - 1), vim.fn["repeat"]({""}, vim.v.count1))
	if eml.direction then
		vim.api.nvim_feedkeys(vim.v.count1 .. "j", "n", false)
	else
		vim.api.nvim_feedkeys(vim.v.count1 .. "k", "n", false)
	end
end
