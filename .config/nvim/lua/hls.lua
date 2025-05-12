local M = {}

M.config = {
	hl_group = "Visual",
}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

M.cache = {
	match_id = {
		-- win1 = {id1, id2, id3, ...},
		-- win2 = {id1, id2, id3, ...},
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

-- # nvim_buf_set_text
-- https://github.com/neovim/neovim/issues/33935

M.nvim_buf_get_text = function(buffer, start_row, start_col, end_row, end_col, opts)
	local end_pos = {
		end_row,
		end_col,
	}
	local last_pos = {
		vim.api.nvim_buf_line_count(buffer),
		0,
	}
	if vim.deep_equal(end_pos, last_pos) then
		local last_pos_pre = M.pos_exclusive2inclusive(last_pos)
		local texts = vim.api.nvim_buf_get_text(
			buffer,
			start_row,
			start_col,
			last_pos_pre[1],
			last_pos_pre[2],
			opts
		)
		table.insert(texts, "")
		return texts
	else
		local texts = vim.api.nvim_buf_get_text(
			buffer,
			start_row,
			start_col,
			end_row,
			end_col,
			opts
		)
		return texts
	end
end

-- # hls

M.add_match = function(pattern)
	local win = vim.api.nvim_get_current_win()
	if not vim.list_contains(vim.tbl_keys(M.cache.match_id), win) then
		M.cache.match_id[win] = {}
	end

	local id =
	vim.fn.matchadd(
		M.config.hl_group,
		pattern
	)

	if not vim.list_contains(M.cache.match_id[win], id) then
		table.insert(M.cache.match_id[win], id)
	end
end

M.ranges_set_matches = function(ranges)
	for _, range in ipairs(ranges) do
		local pos_a = range[1]
		local pos_b = M.pos_inclusive2exclusive(range[2])
		local text
		text = M.nvim_buf_get_text(
			0,
			pos_a[1],
			pos_a[2],
			pos_b[1],
			pos_b[2],
			{}
		)
		text = vim.tbl_map(
			function(x)
				return
				vim.fn.escape(x, [[\]])
			end,
			text
		)
		text = [[\V\C]] .. table.concat(text, [[\n]])
		M.add_match(text)
	end
end

-- M.is_range_contain_pos = function(range, pos)
-- 	local pos_a = range[1]
-- 	local pos_b = range[2]
-- 	local after_pos_a =
-- 		pos[1] > pos_a[1]
-- 		or
-- 		pos[1] == pos_a[1] and pos[2] >= pos_a[2]
-- 	local before_pos_b =
-- 		pos[1] < pos_b[1]
-- 		or
-- 		pos[1] == pos_b[1] and pos[2] <= pos_b[2]
-- 	return
-- 	after_pos_a and before_pos_b
-- end

-- M.is_range_contain_pattern = function(range, pattern)
-- 	local pos_a = range[1]
-- 	local pos_b = range[2]
-- 	local matches = vim.fn.matchbufline(
-- 		vim.api.nvim_get_current_buf(),
-- 		pattern,
-- 		pos_a[1] + 1,
-- 		pos_b[1] + 1
-- 	)
-- 	for _, i in ipairs(matches) do
-- 		local pos = {
-- 			i.lnum - 1,
-- 			i.byteidx,
-- 		}
-- 		if M.is_range_contain_pos(range, pos) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

M.is_range_contain_pattern = function(range, pattern)
	local pos_a = range[1]
	local pos_b = M.pos_inclusive2exclusive(range[2])
	local text
	text = M.nvim_buf_get_text(
		0,
		pos_a[1],
		pos_a[2],
		pos_b[1],
		pos_b[2],
		{}
	)
	text = table.concat(text, "\n")
	local match_idx = vim.fn.match(text, pattern)
	if match_idx == -1 then
		return false
	else
		return true
	end
end

M.is_ranges_contain_pattern = function(ranges, pattern)
	for _, range in ipairs(ranges) do
		if M.is_range_contain_pattern(range, pattern) then
			return true
		end
	end
	return false
end

M.ranges_get_matches = function(ranges)
	local win = vim.api.nvim_get_current_win()

	return
	vim.tbl_filter(
		function(x)
			return
			vim.list_contains(vim.tbl_keys(M.cache.match_id), win)
			and
			vim.list_contains(M.cache.match_id[win], x.id)
			and
			M.is_ranges_contain_pattern(ranges, x.pattern)
		end,
		vim.fn.getmatches(win)
	)
end

M.del_matches = function(matches)
	for _, i in ipairs(matches) do
		vim.fn.matchdelete(i.id)
	end
end

M.hl = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	M.ranges_set_matches(ranges)
end

M.hl_not = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local matches = M.ranges_get_matches(ranges)
	M.del_matches(matches)
end

M.hl_tog = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local matches = M.ranges_get_matches(ranges)
	if next(matches) ~= nil then
		M.del_matches(matches)
	else
		M.ranges_set_matches(ranges)
	end
end

return M
