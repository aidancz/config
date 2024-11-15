local t =
function()
	vim.go.operatorfunc = "v:lua.t_callback"
end

t_callback =
function()
	local char = vim.fn.getcharstr()
	local pattern = [[\V\C]] .. char

	vim.fn.search(pattern, "")

	vim.fn.setreg("/", pattern)
	vim.v.searchforward = 1
end

T_callback =
function()
	local char = vim.fn.getcharstr()
	local pattern = [[\V\C]] .. char

	vim.fn.search(pattern, "b")

	vim.fn.setreg("/", pattern)
	vim.v.searchforward = 0
end

vim.keymap.set({"n", "x"}, "t", t)
vim.keymap.set({"n", "x"}, "T", T)
