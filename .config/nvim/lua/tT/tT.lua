tT = {}

tT.fun = function(direction)
	tT.direction = direction
	tT.char = vim.fn.getcharstr()
	vim.go.operatorfunc = "v:lua.tT.fun_callback"
	return "g@l"
end

tT.fun_callback = function()
	local pattern = [[\V\C]] .. tT.char

	if tT.direction then
		vim.fn.search(pattern, "")
	else
		vim.fn.search(pattern, "b")
	end

	vim.fn.setreg("/", pattern)

	if tT.direction then
		vim.v.searchforward = 1
	else
		vim.v.searchforward = 0
	end
end
