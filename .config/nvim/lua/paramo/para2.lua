local M = {}

local PARA2_TYPE1 = 1
local PARA2_TYPE2 = 2



M.type = function(lnum, virtcol)
	local virtcol_max = vim.fn.virtcol({lnum, "$"})
	local a = virtcol >= virtcol_max
	if a then
		return PARA2_TYPE2
	else
		local col = vim.fn.virtcol2col(0, lnum, virtcol)
		local char = vim.api.nvim_buf_get_text(0, lnum-1, col-1, lnum-1, col-1+1, {})[1]
		local prestr = vim.api.nvim_buf_get_text(0, lnum-1, 0, lnum-1, col-1+1, {})[1]
		local b = (char == " " or char == "\t") and (prestr:match("^%s*$") ~= nil)
		if b then
			return PARA2_TYPE2
		else
			return PARA2_TYPE1
		end
	end
end

M.type1_head_p = function(lnum, virtcol)
	local a = M.type(lnum, virtcol) == PARA2_TYPE1
	local b = lnum == 1
	local c = M.type(lnum-1, virtcol) == PARA2_TYPE2
	if a and (b or c) then
		return true
	else
		return false
	end
end

M.type1_tail_p = function(lnum, virtcol)
	local a = M.type(lnum, virtcol) == PARA2_TYPE1
	local b = lnum == vim.fn.line("$")
	local c = M.type(lnum+1, virtcol) == PARA2_TYPE2
	if a and (b or c) then
		return true
	else
		return false
	end
end

M.type2_head_p = function(lnum, virtcol)
	local a = M.type(lnum, virtcol) == PARA2_TYPE2
	local b = lnum == 1
	local c = M.type(lnum-1, virtcol) == PARA2_TYPE1
	if a and (b or c) then
		return true
	else
		return false
	end
end

M.type2_tail_p = function(lnum, virtcol)
	local a = M.type(lnum, virtcol) == PARA2_TYPE2
	local b = lnum == vim.fn.line("$")
	local c = M.type(lnum+1, virtcol) == PARA2_TYPE1
	if a and (b or c) then
		return true
	else
		return false
	end
end

M.backward_lnum = function(lnum, virtcol)
	if lnum == 1 then
		return lnum
	end
	if M.type1_head_p(lnum-1, virtcol) or M.type2_head_p(lnum-1, virtcol) then
		return lnum - 1
	end
	return M.backward_lnum(lnum - 1, virtcol)
end

M.forward_lnum = function(lnum, virtcol)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if M.type1_tail_p(lnum+1, virtcol) or M.type2_tail_p(lnum+1, virtcol) then
		return lnum + 1
	end
	return M.forward_lnum(lnum + 1, virtcol)
end

M.rep_call = function(func, arg1, arg2, count)
	if count == 0 then
		return func(arg1, arg2)
	else
		return M.rep_call(func, func(arg1, arg2), arg2, (count - 1))
	end
end

M.backward = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = M.rep_call(M.backward_lnum, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

M.forward = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = M.rep_call(M.forward_lnum, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end



M.backward_lnum_special = function(lnum, virtcol)
	if lnum == 1 then
		return lnum
	end
	if M.type1_head_p(lnum-1, virtcol) then
		return lnum - 1
	end
	return M.backward_lnum_special(lnum - 1, virtcol)
end

M.forward_lnum_special = function(lnum, virtcol)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if M.type1_head_p(lnum+1, virtcol) then
		return lnum + 1
	end
	return M.forward_lnum_special(lnum + 1, virtcol)
end

M.backward_special = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = M.rep_call(M.backward_lnum_special, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

M.forward_special = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = M.rep_call(M.forward_lnum_special, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

return M
