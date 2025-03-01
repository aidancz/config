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
		-- "%S",
		"%<",
		"%=",
		Statusline.macro(),
		"(" .. math.max(1, vim.fn.col(".")) .. " " .. vim.fn.col("$") .. ")",
		"(" .. vim.fn.line(".") .. " " .. vim.fn.line("$") .. ")",
		-- "(%v " .. vim.fn.virtcol("$") .. ")",
		-- "(%l %L)",
	}
	return table.concat(list, " ")
end

Statusline.str_inactive = function()
	local list = {
		"%t",
	}
	return table.concat(list, " ")
end



-- Statusline.nvim_recorder = function()
-- 	if package.loaded["recorder"] then
-- 		return package.loaded["recorder"].displaySlots()
-- 	else
-- 		return ""
-- 	end
-- end

-- Statusline.NeoComposer = function()
-- 	if package.loaded["NeoComposer.ui"] then
-- 		return package.loaded["NeoComposer.ui"].status_recording()
-- 	else
-- 		return ""
-- 	end
-- end

Statusline.macro = function()
	local M = package.loaded["macro"]
	if M then
		local reg = M.get_reg()
		local macro = M.internal2visual(M.get_macro(M.get_reg()))
		return string.format("(%s %s)", reg, macro)
	else
		return ""
	end
end
