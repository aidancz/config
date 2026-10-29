local M = {}

-- # function: macro

M.visual2internal = function(str)
-- e.g. <c-f> to ^F
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.internal2visual = function(str)
-- e.g. ^F to <c-f>
	return vim.fn.keytrans(str)
end

M.visual2visual = function(str)
-- e.g. <c-f> to <C-F>
	return M.internal2visual(M.visual2internal(str))
end

M.internal2internal = function(str)
-- e.g. <80><fc>^DF to ^F
	return M.visual2internal(M.internal2visual(str))
end

M.get_macro = function(reg)
	return M.internal2internal(vim.fn.getreg(reg))
	-- https://github.com/chrisgrieser/nvim-recorder
end

M.set_macro = function(reg, str)
	vim.fn.setreg(reg, str, "c")
end

-- # function: api

M.edit = function()
	vim.ui.input(
		{
			prompt = "reg: ",
			default = vim.fn.reg_recorded(),
		},
		function(input)
			if not input then return end
			if input == "" then return end
			local reg = input
			vim.ui.input(
				{
					default = M.internal2visual(M.get_macro(reg))
				},
				function(input)
					if not input then return end
					M.set_macro(reg, M.visual2internal(input))
				end
			)
		end
	)
end

-- # return

return M
