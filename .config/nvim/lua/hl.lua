local M = {}

M.config = {
	extmark_opts = {
		hl_eol = true,
		hl_group = "nofrils_blue_bg",
		priority = 101,
	},
}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

M.cache = {
	extmark_ns_id = vim.api.nvim_create_namespace("hl"),
	extmark_id = {
		-- buf1 = {id1, id2, id3, ...},
		-- buf2 = {id1, id2, id3, ...},
		-- ...
	},
}

---@param line number
---@param col number
---@param opts {
---	end_row: number,
---	end_col: number,
---}
M.set_extmark = function(line, col, opts)
	local buf = vim.api.nvim_get_current_buf()
	if not vim.list_contains(vim.tbl_keys(M.cache.extmark_id), buf) then
		M.cache.extmark_id[buf] = {}
	end

	local id =
	vim.api.nvim_buf_set_extmark(
		buf,
		M.cache.extmark_ns_id,
		line,
		col,
		vim.tbl_deep_extend(
			"force",
			M.config.extmark_opts,
			opts
		)
	)

	if not vim.list_contains(M.cache.extmark_id[buf], id) then
		table.insert(M.cache.extmark_id[buf], id)
	end
end

M.del_extmark = function()
	for buf, ids in pairs(M.cache.extmark_id) do
		vim.api.nvim_buf_clear_namespace(buf, M.cache.extmark_ns_id, 0, -1)
	end
	M.cache.extmark_id = {}
end

-- # dot-repeat --------------------------------

M.hl = function(mode)
	local row1_a, col0_a = unpack(vim.api.nvim_buf_get_mark(0, "["))
	local row0_a = row1_a - 1
	local row1_b, col0_b = unpack(vim.api.nvim_buf_get_mark(0, "]"))
	local row0_b = row1_b - 1

	-- vim.print({row0_a, col0_a, row0_b, col0_b})

	local get_col0_max = function(row0)
		local row1 = row0 + 1
		local col1_max = vim.fn.col({row1, "$"})
		local col0_max = col1_max - 1
		return col0_max
	end

	local ranges = {}
	local ranges_insert = function(range)
		table.insert(ranges, range)
	end
	if mode == "char" then
		if col0_b + 1 <= get_col0_max(row0_b) then
			ranges_insert({
				row0_a,
				col0_a,
				row0_b,
				col0_b + 1,
			})
		else
			ranges_insert({
				row0_a,
				col0_a,
				row0_b + 1,
				0,
			})
		end
	elseif mode == "line" then
		ranges_insert({
			row0_a,
			0,
			row0_b + 1,
			0,
		})
	elseif mode == "block" then
		if col0_b == get_col0_max(row0_b) then
			col0_b = col0_b - 1
			-- ignore eol in block mode
		end
		for row0 = row0_a, row0_b do
			local col0_max = get_col0_max(row0) - 1
			-- ignore eol in block mode

			if col0_max < col0_a then
				-- continue
			elseif col0_max <= col0_b then
				ranges_insert({
					row0,
					col0_a,
					row0,
					col0_max + 1,
				})
			else
				ranges_insert({
					row0,
					col0_a,
					row0,
					col0_b + 1,
				})
			end
		end
	end

	for _, range in ipairs(ranges) do
		M.set_extmark(
			range[1],
			range[2],
			{
				end_row = range[3],
				end_col = range[4],
			}
		)
	end
end

M.expr = function()
	vim.o.operatorfunc = [[v:lua.require'hl'.hl]]
	return "g@"
end

-- ^ dot-repeat --------------------------------

return M
