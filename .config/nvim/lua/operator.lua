local M = {}

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
		return {
			pos[1],
			pos[2] + 1,
		}
	else
		return {
			pos[1] + 1,
			0,
		}
	end
end

M.pos_exclusive2inclusive = function(pos)
	if pos[2] - 1 >= 0 then
		return {
			pos[1],
			pos[2] - 1,
		}
	else
		return {
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

M.get_eob_pos = function(buf)
-- eob: end of buffer
	local row1_max = vim.api.nvim_buf_line_count(buf)
	local row0_max = row1_max - 1
	return {
		row0_max + 1,
		0,
	}
end

M.nvim_buf_get_text = function(buf, start_row, start_col, end_row, end_col, opts)
-- https://github.com/neovim/neovim/issues/33935
	local start_pos = {
		start_row,
		start_col,
	}
	local end_pos = {
		end_row,
		end_col,
	}
	local eob_pos = M.get_eob_pos(buf)

	local is_start_eob = vim.deep_equal(start_pos, eob_pos)
	if is_start_eob then
		start_pos = M.pos_exclusive2inclusive(start_pos)
	end
	local is_end_eob = vim.deep_equal(end_pos, eob_pos)
	if is_end_eob then
		end_pos = M.pos_exclusive2inclusive(end_pos)
	end

	local texts = vim.api.nvim_buf_get_text(
		buf,
		start_pos[1],
		start_pos[2],
		end_pos[1],
		end_pos[2],
		opts
	)

	if (is_end_eob) and (not is_start_eob) then
		table.insert(texts, "")
	end
	-- | is_start_eob | is_end_eob | note            |
	-- | ------------ | ---------- | --------------  |
	-- | false        | false      | do nothing      |
	-- | false        | true       | add "" to texts |
	-- | true         | false      | impossible      |
	-- | true         | true       | do nothing      |

	return texts
end

-- # operator: inspect

M.inspect = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	vim.print(ranges)
end

-- # operator: hl

M.hl = {}

M.hl.ns_id = vim.api.nvim_create_namespace("operator.hl")

---@param line number
---@param col number
---@param opts {
---	end_row: number,
---	end_col: number,
---}
M.hl.set_extmark = function(line, col, opts)
	vim.api.nvim_buf_set_extmark(
		0,
		M.hl.ns_id,
		line,
		col,
		vim.tbl_deep_extend(
			"force",
			{
				hl_eol = true,
				hl_group = "Visual",
				priority = 101,
			},
			opts
		)
	)
end

M.hl.ranges_set_extmarks = function(ranges)
	for _, range in ipairs(ranges) do
		local pos_a = range[1]
		local pos_b = M.pos_inclusive2exclusive(range[2])
		M.hl.set_extmark(
			pos_a[1],
			pos_a[2],
			{
				end_row = pos_b[1],
				end_col = pos_b[2],
			}
		)
	end
end

M.hl.ranges_get_extmarks = function(ranges)
	local extmarks = {}
	for _, range in ipairs(ranges) do
		local pos_a = range[1]
		local pos_b = range[2]
		local extmarks_range
		extmarks_range = vim.api.nvim_buf_get_extmarks(
			0,
			M.hl.ns_id,
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
				return not vim.deep_equal(pos_extmark_end, pos_a)
			end,
			extmarks_range
		)
		vim.list_extend(extmarks, extmarks_range)
	end
	return extmarks
end

M.hl.del_extmarks = function(extmarks)
	for _, i in ipairs(extmarks) do
		vim.api.nvim_buf_del_extmark(
			0,
			M.hl.ns_id,
			i[1]
		)
	end
end

M.hl.on = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	M.hl.ranges_set_extmarks(ranges)
end

M.hl.off = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local extmarks = M.hl.ranges_get_extmarks(ranges)
	M.hl.del_extmarks(extmarks)
end

M.hl.tog = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local extmarks = M.hl.ranges_get_extmarks(ranges)
	if vim.tbl_isempty(extmarks) then
		M.hl.ranges_set_extmarks(ranges)
	else
		M.hl.del_extmarks(extmarks)
	end
end

-- # operator: hls

M.hls = {}

M.hls.ids = {
	-- win1 = {id1, id2, id3, ...},
	-- win2 = {id1, id2, id3, ...},
	-- ...
}

M.hls.matchadd = function(pattern)
	local win = vim.api.nvim_get_current_win()
	if not vim.list_contains(vim.tbl_keys(M.hls.ids), win) then
		M.hls.ids[win] = {}
	end

	local id = vim.fn.matchadd("Visual", pattern)

	if not vim.list_contains(M.hls.ids[win], id) then
		table.insert(M.hls.ids[win], id)
	end
end

M.hls.ranges_set_matches = function(ranges)
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
				return vim.fn.escape(x, [[\]])
			end,
			text
		)
		text = [[\V\C]] .. table.concat(text, [[\n]])
		M.hls.matchadd(text)
	end
end

M.hls.is_range_contain_pattern = function(range, pattern)
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

M.hls.is_ranges_contain_pattern = function(ranges, pattern)
	for _, range in ipairs(ranges) do
		if M.hls.is_range_contain_pattern(range, pattern) then
			return true
		end
	end
	return false
end

M.hls.ranges_get_matches = function(ranges)
	local win = vim.api.nvim_get_current_win()
	local matches = vim.fn.getmatches(win)
	return vim.tbl_filter(
		function(x)
			return
				vim.list_contains(vim.tbl_keys(M.hls.ids), win)
				and
				vim.list_contains(M.hls.ids[win], x.id)
				and
				M.hls.is_ranges_contain_pattern(ranges, x.pattern)
		end,
		matches
	)
end

M.hls.matchdelete = function(matches)
	for _, i in ipairs(matches) do
		vim.fn.matchdelete(i.id)
	end
end

M.hls.on = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	M.hls.ranges_set_matches(ranges)
end

M.hls.off = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local matches = M.hls.ranges_get_matches(ranges)
	M.hls.matchdelete(matches)
end

M.hls.tog = function(mode)
	local ranges = M.get_operator_inclusive_ranges(mode)
	local matches = M.hls.ranges_get_matches(ranges)
	if vim.tbl_isempty(matches) then
		M.hls.ranges_set_matches(ranges)
	else
		M.hls.matchdelete(matches)
	end
end

-- # operator: comment_multiply

-- https://www.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/
-- https://www.reddit.com/r/neovim/comments/1k4efz8/comment/mola3k0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

M.comment_multiply = function(_)
	local pos10_a = vim.api.nvim_buf_get_mark(0, "[")
	local pos10_b = vim.api.nvim_buf_get_mark(0, "]")
	local pos00_a = {
		pos10_a[1] - 1,
		pos10_a[2],
	}
	local pos00_b = {
		pos10_b[1] - 1,
		pos10_b[2],
	}

	local lines = vim.api.nvim_buf_get_lines(0, pos00_a[1], pos00_b[1] + 1, true)

	require("mini.comment").toggle_lines(pos10_a[1], pos10_b[1])

	vim.api.nvim_buf_set_lines(
		0,
		pos00_b[1] + 1,
		pos00_b[1] + 1,
		true,
		lines
	)

	vim.api.nvim_win_set_cursor(0, {pos10_b[1] + 1, 0})
	vim.cmd("normal! _")
end

-- # return

return M
