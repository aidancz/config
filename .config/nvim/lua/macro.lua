local M = {}
local H = {}

-- # config & setup

M.config = {
	slot_list = {
		"a",
		"b",
	},
}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
	M.cache.slot_list = M.config.slot_list
end

-- # cache

M.cache = {
	-- slot_list = {
	-- 	"a",
	-- 	"b",
	-- },
	slot_index = 1,
}

-- # function: slot

M.get_lis = function()
	return M.cache.slot_list
end

M.get_idx = function()
	return M.cache.slot_index
end

M.idx2reg = function(idx)
	return M.cache.slot_list[idx]
end

M.reg2idx = function(reg)
	for i, r in ipairs(M.cache.slot_list) do
		if r == reg then
			return i
		end
	end
	return nil
end

M.get_reg = function()
	return M.idx2reg(M.get_idx())
end

M.get_idx_next = function(idx)
	if M.idx2reg(idx + 1) then
		return idx + 1
	else
		return 1
	end
end

M.get_idx_prev = function(idx)
	if M.idx2reg(idx - 1) then
		return idx - 1
	else
		return #M.cache.slot_list
	end
end

M.set_idx = function(idx)
	M.cache.slot_index = idx
end

-- # function: macro

M.visual2internal = function(str)
-- e.g. string("<c-f>") to string(^F)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.internal2visual = function(str)
-- e.g. string(^F) to string("<c-f>")
	return vim.fn.keytrans(str)
end

M.visual2visual = function(str)
-- e.g. string("<c-f>") to string("<C-F>")
	return M.internal2visual(M.visual2internal(str))
end

M.internal2internal = function(str)
-- e.g. string(<80><fc>^DF) to string(^F)
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

M.idx_next = function()
	M.set_idx(M.get_idx_next(M.get_idx()))
end

M.idx_prev = function()
	M.set_idx(M.get_idx_prev(M.get_idx()))
end

M.record_start = function()
	vim.cmd("normal! q" .. M.get_reg())
end

M.record_play = function()
	vim.cmd("normal! @" .. M.get_reg())
end

M.record_edit = function()
	vim.ui.input(
		{
			default = M.internal2visual(M.get_macro(M.get_reg()))
		},
		function(input)
			if not input then return end
			M.set_macro(M.get_reg(), M.visual2internal(input))
		end
	)
end

-- # return

M.setup()
vim.keymap.set(
	"n",
	"q",
	function()
		if vim.fn.reg_recording() == "" then
			return [[<cmd>lua require("macro").record_start()<cr>]]
		else
			return "q"
		end
	end,
	{expr = true}
)
vim.keymap.set("n", "Q", M.record_play)
vim.keymap.set("n", "cq", M.record_edit)
vim.keymap.set("n", "<c-q>", M.idx_next)
return M
