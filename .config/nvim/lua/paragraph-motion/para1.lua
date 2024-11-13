local para1 = {}

para1.head_p = function(lnum)
	if lnum == 1 then
		return true
	end
	if vim.fn.getline(lnum) ~= "" and vim.fn.getline(lnum - 1) == "" then
		return true
	end
	return false
end

para1.tail_p = function(lnum)
	if lnum == vim.fn.line("$") then
		return true
	end
	if vim.fn.getline(lnum) ~= "" and vim.fn.getline(lnum + 1) == "" then
		return true
	end
	return false
end

para1.backward_lnum = function(lnum)
	if lnum == 1 then
		return lnum
	end
	if para1.head_p(lnum - 1) then
		return lnum - 1
	end
	return para1.backward_lnum(lnum - 1)
end

para1.forward_lnum = function(lnum)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if para1.tail_p(lnum + 1) then
		return lnum + 1
	end
	return para1.forward_lnum(lnum + 1)
end

para1.rep_call = function(func, arg, count)
	if count == 0 then
		return func(arg)
	else
		return para1.rep_call(func, func(arg), (count - 1))
	end
end

para1.backward = function()
	local lnum_current = vim.fn.line(".")
	local lnum_destination = para1.rep_call(para1.backward_lnum, lnum_current, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

para1.forward = function()
	local lnum_current = vim.fn.line(".")
	local lnum_destination = para1.rep_call(para1.forward_lnum, lnum_current, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

return para1
