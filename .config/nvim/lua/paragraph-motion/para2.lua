local para2 = {}

local PARA2_TYPE1 = 1
local PARA2_TYPE2 = 2



para2.type = function(lnum, virtcol)
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

para2.type1_head_p = function(lnum, virtcol)
	local a = para2.type(lnum, virtcol) == PARA2_TYPE1
	local b = lnum == 1
	local c = para2.type(lnum-1, virtcol) == PARA2_TYPE2
	if a and (b or c) then
		return true
	else
		return false
	end
end

para2.type1_tail_p = function(lnum, virtcol)
	local a = para2.type(lnum, virtcol) == PARA2_TYPE1
	local b = lnum == vim.fn.line("$")
	local c = para2.type(lnum+1, virtcol) == PARA2_TYPE2
	if a and (b or c) then
		return true
	else
		return false
	end
end

para2.type2_head_p = function(lnum, virtcol)
	local a = para2.type(lnum, virtcol) == PARA2_TYPE2
	local b = lnum == 1
	local c = para2.type(lnum-1, virtcol) == PARA2_TYPE1
	if a and (b or c) then
		return true
	else
		return false
	end
end

para2.type2_tail_p = function(lnum, virtcol)
	local a = para2.type(lnum, virtcol) == PARA2_TYPE2
	local b = lnum == vim.fn.line("$")
	local c = para2.type(lnum+1, virtcol) == PARA2_TYPE1
	if a and (b or c) then
		return true
	else
		return false
	end
end

para2.backward_lnum = function(lnum, virtcol)
	if lnum == 1 then
		return lnum
	end
	if para2.type1_head_p(lnum-1, virtcol) or para2.type2_head_p(lnum-1, virtcol) then
		return lnum - 1
	end
	return para2.backward_lnum(lnum - 1, virtcol)
end

para2.forward_lnum = function(lnum, virtcol)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if para2.type1_tail_p(lnum+1, virtcol) or para2.type2_tail_p(lnum+1, virtcol) then
		return lnum + 1
	end
	return para2.forward_lnum(lnum + 1, virtcol)
end

para2.rep_call = function(func, arg1, arg2, count)
	if count == 0 then
		return func(arg1, arg2)
	else
		return para2.rep_call(func, func(arg1, arg2), arg2, (count - 1))
	end
end

para2.backward = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2.rep_call(para2.backward_lnum, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

para2.forward = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2.rep_call(para2.forward_lnum, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end



para2.backward_lnum_special = function(lnum, virtcol)
	if lnum == 1 then
		return lnum
	end
	if para2.type1_head_p(lnum-1, virtcol) then
		return lnum - 1
	end
	return para2.backward_lnum_special(lnum - 1, virtcol)
end

para2.forward_lnum_special = function(lnum, virtcol)
	if lnum == vim.fn.line("$") then
		return lnum
	end
	if para2.type1_head_p(lnum+1, virtcol) then
		return lnum + 1
	end
	return para2.forward_lnum_special(lnum + 1, virtcol)
end

para2.backward_special = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2.rep_call(para2.backward_lnum_special, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

para2.forward_special = function()
	local lnum_current = vim.fn.line(".")
	local virtcol = vim.fn.virtcol(".")
	local lnum_destination = para2.rep_call(para2.forward_lnum_special, lnum_current, virtcol, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

return para2
