local M = {}

M.config = {
	extmark_opts = {
		hl_eol = true,
		hl_group = "Visual",
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

-- # help functions

M.get_mark_pos = function(mark)
	local pos10 = vim.api.nvim_buf_get_mark(0, mark)
	local pos00 = {
		pos10[1] - 1,
		pos10[2],
	}
	return pos00
end

M.get_col_max = function(row0)
	local row1 = row0 + 1
	local col1_max = vim.fn.col({row1, "$"})
	local col0_max = col1_max - 1
	return col0_max
end

M.pos_inclusive2exclusive = function(pos)
	if pos[2] + 1 <= M.get_col_max(pos[1]) then
		return
		{
			pos[1],
			pos[2] + 1,
		}
	else
		return
		{
			pos[1] + 1,
			0,
		}
	end
end

M.pos_exclusive2inclusive = function(pos)
	if pos[2] - 1 >= 0 then
		return
		{
			pos[1],
			pos[2] - 1,
		}
	else
		return
		{
			pos[1] - 1,
			M.get_col_max(pos[1] - 1),
		}
	end
end

M.get_operator_inclusive_ranges = function(mode)
	local pos_a = M.get_mark_pos("[")
	local pos_b = M.get_mark_pos("]")

	local ranges = {}
	local ranges_insert = function(range)
		table.insert(ranges, range)
	end
	if mode == "char" then
		ranges_insert({
			pos_a,
			pos_b,
		})
	elseif mode == "line" then
		ranges_insert({
			{
				pos_a[1],
				0,
			},
			{
				pos_b[1],
				M.get_col_max(pos_b[1]),
			},
		})
	elseif mode == "block" then
		local row_a = pos_a[1]
		local col_a = pos_a[2]
		local row_b = pos_b[1]
		local col_b = pos_b[2]
		if not (col_a <= col_b) then
			col_a, col_b = col_b, col_a
		end
		for row = row_a, row_b do
			local col_max = M.get_col_max(row)
			if col_max < col_a then
				-- continue
			elseif col_max <= col_b then
				ranges_insert({
					{
						row,
						col_a,
					},
					{
						row,
						col_max,
					},
				})
			else
				ranges_insert({
					{
						row,
						col_a,
					},
					{
						row,
						col_b,
					},
				})
			end
		end
	end
	return ranges
end

-- # hl

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

M.ranges_set_extmarks = function(ranges)
	for _, range in ipairs(ranges) do
		local pos_a = range[1]
		local pos_b = M.pos_inclusive2exclusive(range[2])
		M.set_extmark(
			pos_a[1],
			pos_a[2],
			{
				end_row = pos_b[1],
				end_col = pos_b[2],
			}
		)
	end
end

M.ranges_get_extmarks = function(ranges)
	local extmarks = {}
	for _, range in ipairs(ranges) do
		local pos_a = range[1]
		local pos_b = range[2]
		local extmarks_range
		extmarks_range = vim.api.nvim_buf_get_extmarks(
			0,
			M.cache.extmark_ns_id,
			pos_a,
			pos_b,
			{
				details = true,
				overlap = true,
				type = "highlight",
			}
		)
		extmarks_range = vim.tbl_filter(
		-- we want `exclusive overlap`
			function(x)
				local pos_extmark_end = {
					x[4].end_row,
					x[4].end_col,
				}
				return
				not vim.deep_equal(pos_extmark_end, pos_a)
			end,
			extmarks_range
		)
		vim.list_extend(extmarks, extmarks_range)
	end
	return extmarks
end

M.del_extmarks = function(extmarks)
	for _, i in ipairs(extmarks) do
		vim.api.nvim_buf_del_extmark(
			0,
			M.cache.extmark_ns_id,
			i[1]
		)
	end
end

M.hl = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	M.ranges_set_extmarks(ranges)
end

M.hl_not = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local extmarks = M.ranges_get_extmarks(ranges)
	M.del_extmarks(extmarks)
end

M.hl_tog = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local extmarks = M.ranges_get_extmarks(ranges)
	if next(extmarks) ~= nil then
		M.del_extmarks(extmarks)
	else
		M.ranges_set_extmarks(ranges)
	end
end

return M
