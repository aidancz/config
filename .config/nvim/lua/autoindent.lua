local M = {}

M.lead = function(lnum)
	local line = vim.fn.getline(lnum)
	local lead = string.match(line, "^(%s*)")
	return lead
end

M.line_is_nonempty = function(lnum)
	local line = vim.fn.getline(lnum)
	return line ~= ""
end

M.lnum_prev_nonempty = function(lnum)
	if lnum == 1 then
		return nil
	end
	if M.line_is_nonempty(lnum - 1) then
		return lnum - 1
	end
	return M.lnum_prev_nonempty(lnum - 1)
end

M.lnum_next_nonempty = function(lnum)
	if lnum == vim.fn.line("$") then
		return nil
	end
	if M.line_is_nonempty(lnum + 1) then
		return lnum + 1
	end
	return M.lnum_next_nonempty(lnum + 1)
end

M.lead_prev_nonempty = function(lnum)
	local lnum_prev_nonempty = M.lnum_prev_nonempty(lnum)
	if lnum_prev_nonempty == nil then
		return ""
	else
		return M.lead(lnum_prev_nonempty)
	end
end

M.lead_next_nonempty = function(lnum)
	local lnum_next_nonempty = M.lnum_next_nonempty(lnum)
	if lnum_next_nonempty == nil then
		return ""
	else
		return M.lead(lnum_next_nonempty)
	end
end

M.lead_max = function(lnum)
	local lead_prev_nonempty = M.lead_prev_nonempty(lnum)
	local lead_next_nonempty = M.lead_next_nonempty(lnum)
	if #lead_prev_nonempty >= #lead_next_nonempty then
		return lead_prev_nonempty
	else
		return lead_next_nonempty
	end
end

M.insert_indent = function()
	local lead_max = M.lead_max(vim.fn.line("."))

	vim.api.nvim_paste(lead_max, false, -1)
	-- vim.api.nvim_put({lead_max}, "c", false, true)
	-- vim.api.nvim_feedkeys(lead_max, "n", false)
end

M.indent_if_col1 = function()
	if vim.fn.col(".") ~= 1 then return end
	M.insert_indent()
end

M.indent_if_empty = function()
	if vim.fn.getline(".") ~= "" then return end
	M.insert_indent()
end

-- return M

vim.keymap.set(
	"i",
	"<cr>",
	function()
		vim.api.nvim_paste("\n", false, -1)
		M.indent_if_col1()
	end
)

vim.keymap.set(
	"i",
	"<s-cr>",
	"<cr><cmd>.m.-2<cr>",
	{
		remap = true
	}
)

vim.api.nvim_create_augroup("autoindent", {clear = true})
vim.api.nvim_create_autocmd(
	"ModeChanged",
	{
		group = "autoindent",
		pattern = "*:i*",
		callback = function()
			M.indent_if_empty()
		end,
	}
)
