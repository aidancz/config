local M = {}
local V = require("virtcol")

-- M.save = function()
-- 	vim.cmd("normal! md")
-- end
-- M.load = function()
-- 	vim.cmd("normal! `d")
-- end

M.cache = {
	ns_id = vim.api.nvim_create_namespace("fix-cursor"),
	-- id = ...,
}

M.save = function()
	M.pos_v_save = V.get_cursor()

	local row1 = M.pos_v_save.lnum
	local row0 = row1 - 1
	M.cache.id = vim.api.nvim_buf_set_extmark(
		0,
		M.cache.ns_id,
		row0,
		0,
		{
			-- id = M.cache.id,
			end_row = row0 + 1,
			end_col = 0,
			right_gravity = false,
			end_right_gravity = false,
			-- hl_eol = true,
			-- hl_group = "Visual",
			-- priority = 101,
		}
	)
	local pos_e = vim.api.nvim_buf_get_extmark_by_id(0, M.cache.ns_id, M.cache.id, {details = true})
	M.text_save = require("hls").nvim_buf_get_text(0, pos_e[1], pos_e[2], pos_e[3].end_row, pos_e[3].end_col, {})
end

M.load = function()
	local pos_e = vim.api.nvim_buf_get_extmark_by_id(0, M.cache.ns_id, M.cache.id, {details = true})
	vim.api.nvim_buf_del_extmark(0, M.cache.ns_id, M.cache.id)
	M.text_load = require("hls").nvim_buf_get_text(0, pos_e[1], pos_e[2], pos_e[3].end_row, pos_e[3].end_col, {})

	M.pos_v_load = {}

	local row0 = pos_e[1]
	local row1 = row0 + 1
	row1 = math.min(row1, vim.api.nvim_buf_line_count(0))
	M.pos_v_load.lnum = row1

	M.pos_v_load.virtcol = M.pos_v_save.virtcol
	if not vim.deep_equal(M.text_load, M.text_save) then
		local divisor = V.width_editable_text()

		local space_save = math.ceil(M.pos_v_save.virtcol / divisor)

		local virtcol_max_load = V.virtcol_max_real(M.pos_v_load.lnum)
		local space_load_max = math.ceil(virtcol_max_load / divisor)

		if space_load_max < space_save then
			M.pos_v_load.virtcol = (space_load_max - 1) * divisor + (M.pos_v_save.virtcol % divisor)
		end
	end

	-- vim.print(M.pos_v_load)
	V.set_cursor(M.pos_v_load)
end

M.load_later = function(when)
	if when == "schedule" then
		vim.schedule(M.load)
	else
		vim.api.nvim_create_autocmd(
			"ModeChanged",
			{
				pattern = when,
				callback = M.load,
				once = true,
			}
		)
	end
end

M.wrap = function(key, when, replace_keycodes)
	local dict = vim.fn.maparg(key, "n", false, true)

	if vim.tbl_isempty(dict) then
		vim.keymap.set(
			"n",
			key,
			function()
				require("fix-cursor").save()
				require("fix-cursor").load_later(when)
				return key
			end,
			{
				expr = true,
				replace_keycodes = replace_keycodes,
				remap = false,
			}
		)
		return
	end

	if dict.rhs ~= nil then
		local expr
		if dict.expr == 0 then expr = false else expr = true end

		local remap
		if dict.noremap == 0 then remap = true else remap = false end

		local rhs = dict.rhs

		if expr == false then
			vim.keymap.set(
				"n",
				key,
				function()
					require("fix-cursor").save()
					require("fix-cursor").load_later(when)
					return rhs
				end,
				{
					expr = true,
					replace_keycodes = replace_keycodes,
					remap = remap,
				}
			)
		else
			vim.keymap.set(
				"n",
				key,
				function()
					require("fix-cursor").save()
					require("fix-cursor").load_later(when)
					return vim.api.nvim_eval(rhs)
				end,
				{
					expr = true,
					replace_keycodes = replace_keycodes,
					remap = remap,
				}
			)
		end
		return
	end

	if dict.callback ~= nil then
		local expr
		if dict.expr == 0 then expr = false else expr = true end

		local remap
		if dict.noremap == 0 then remap = true else remap = false end

		-- local replace_keycodes
		-- if dict.replace_keycodes == nil then replace_keycodes = false end
		-- if dict.replace_keycodes == 1   then replace_keycodes = true  end

		local callback = dict.callback

		if expr == false then
			vim.keymap.set(
				"n",
				key,
				function()
					require("fix-cursor").save()
					require("fix-cursor").load_later(when)
					callback()
				end,
				{
					expr = false,
				}
			)
		else
			vim.keymap.set(
				"n",
				key,
				function()
					require("fix-cursor").save()
					require("fix-cursor").load_later(when)
					return callback()
				end,
				{
					expr = true,
					replace_keycodes = replace_keycodes,
					remap = remap,
				}
			)
		end
		return
	end
end

return M
