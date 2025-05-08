local M = {}
local H = {}

-- # config & setup

M.config = {
	buf_name = "[luaeval]",
	buf_opt = {
		filetype = "lua",
	},
	win = {
		relative = "editor",
		row = 0,
		col = 0,
		width = vim.o.columns - 2,
		height = vim.o.lines - vim.o.cmdheight - 2 - 1,
		title = "luaeval",
	},
	win_enter = true,
	win_opt = {
		winfixbuf = true,
		winfixwidth = true,
		winfixheight = true,
	},
	hook_open = nil,
	hook_close = nil,
}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
	M.buf_set_true()
	-- M.autocmd()
end

-- # cache

M.cache = {
	buf_handle = nil,
	win_handle = nil,
	origin_win_handle = nil,
}

-- # function: buffer

M.buf_is_valid = function()
	return
		M.cache.buf_handle ~= nil
		and
		vim.api.nvim_buf_is_valid(M.cache.buf_handle)
end

M.buf_set_false = function()
	if M.buf_is_valid() then
		vim.api.nvim_buf_delete(M.cache.buf_handle, {force = true})
	else
		-- do nothing
	end
end

M.buf_set_true = function()
	if M.buf_is_valid() then
		-- do nothing
	else
		M.cache.buf_handle = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(M.cache.buf_handle, M.config.buf_name)
		-- M.cache.buf_handle = vim.fn.bufadd(vim.fn.stdpath("cache") .. "/luaeval.lua")
		-- vim.fn.bufload(M.cache.buf_handle)
		for option, value in pairs(M.config.buf_opt) do
			vim.api.nvim_set_option_value(option, value, {buf = M.cache.buf_handle})
		end
	end
end

M.buf_set_lines = function(lines)
	vim.api.nvim_buf_set_lines(
		M.cache.buf_handle,
		0,
		-1,
		true,
		lines
	)
end

-- # function: window

M.win_is_valid = function()
	return
		M.cache.win_handle ~= nil
		and
		vim.api.nvim_win_is_valid(M.cache.win_handle)
end

M.win_set_false = function()
	if M.win_is_valid() then
		vim.api.nvim_win_close(M.cache.win_handle, true)
	else
		-- do nothing
	end
end

M.win_set_true = function()
	if M.win_is_valid() then
		-- do nothing
	else
		M.cache.win_handle = vim.api.nvim_open_win(
			M.cache.buf_handle,
			M.config.win_enter,
			M.config.win
		)
		for option, value in pairs(M.config.win_opt) do
			vim.api.nvim_set_option_value(option, value, {win = M.cache.win_handle})
		end
	end
end

-- # function: main

---@param code_tbl string[]
---@return string cmd
M.code2cmd = function(code_tbl)
	table.insert(code_tbl, 1, "lua << EOF")
	table.insert(code_tbl, "EOF")

	local code_str
	code_str = vim.inspect(code_tbl):gsub("\n", " ")

	local cmd
	cmd = [[lua vim.cmd(table.concat(]] .. code_str .. [[, "\n"))]]
	return cmd
end

---@param cmd string
---@return string[]|nil code_tbl
M.cmd2code = function(cmd)
	if string.sub(cmd, 1, 25) ~= [[lua vim.cmd(table.concat(]] then return end

	local code_str = string.sub(cmd, 1+25, -(1+8))

	local f = load("return " .. code_str)
	if not f then return end
	local code_tbl = f()
	table.remove(code_tbl, 1)
	table.remove(code_tbl)
	return code_tbl
end

M.wrap = function(code_tbl, wrap)
	if wrap == nil then
		return
	elseif wrap == "vim.print" then
		table.insert(code_tbl, 1, "vim.print(")
		table.insert(code_tbl, ")")
	elseif wrap == "vim.cmd" then
		table.insert(code_tbl, 1, "vim.cmd([[")
		table.insert(code_tbl, "]])")
	elseif wrap == "vim.cmd.normal" then
		table.insert(code_tbl, 1, "vim.cmd.normal([[")
		code_tbl[#code_tbl] = code_tbl[#code_tbl] .. "]])"
	elseif wrap == "vim.api.nvim_feedkeys" then
		table.insert(code_tbl, 1, "vim.api.nvim_feedkeys([[")
		code_tbl[#code_tbl] = code_tbl[#code_tbl] .. "]], [[t]], true)"
	end
end

---@param opts? {
---	wrap?: string,
---}
M.eval = function(opts)
	opts = opts or {}

	local code_tbl = vim.api.nvim_buf_get_lines(M.cache.buf_handle, 0, -1, true)
	M.wrap(code_tbl, opts.wrap)

	local cmd = M.code2cmd(code_tbl)
	vim.cmd(cmd)
	vim.fn.histadd("cmd", cmd)
end

-- M.record_origin_win = function()
-- 	M.cache.origin_win_handle = vim.api.nvim_get_current_win()
-- end

-- M.retrieve_origin_win = function()
-- 	if not vim.api.nvim_win_is_valid(M.cache.origin_win_handle) then return end
-- 	vim.api.nvim_set_current_win(M.cache.origin_win_handle)
-- end

M.open = function()
	-- M.record_origin_win()
	-- M.buf_set_true()
	M.win_set_true()
	M.config.hook_open()
end

M.close = function()
	-- M.retrieve_origin_win()
	-- M.buf_set_false()
	M.win_set_false()
	M.config.hook_close()
end

-- M.autocmd = function()
-- 	vim.api.nvim_create_augroup("luaexec", {clear = true})
-- 	vim.api.nvim_create_autocmd(
-- 		{
-- 			"WinClosed",
-- 		},
-- 		{
-- 			group = "luaexec",
-- 			callback = function(event)
-- 				local closing_window_handle = tonumber(event.match)
-- 				if closing_window_handle == M.cache.win_handle then
-- 					M.close()
-- 				end
-- 			end,
-- 		}
-- 	)
-- end

M.toggle = function()
	if M.win_is_valid() then
		M.close()
	else
		M.open()
	end
end

-- # return

return M
