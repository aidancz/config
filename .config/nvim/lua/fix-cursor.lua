local M = {}

-- M.save = function()
-- 	vim.cmd("normal! md")
-- end

-- M.load = function()
-- 	vim.cmd("normal! `d")
-- end

-- NOTE: normal mark becomes invalid when the text is changed, so use extmark instead

M.cache = {
	ns_id = vim.api.nvim_create_namespace("fix-cursor"),
}

M.save = function()
	local id = vim.api.nvim_buf_set_extmark(
		0,
		M.cache.ns_id,
		vim.fn.line(".") - 1,
		vim.fn.col(".") - 1,
		{
			right_gravity = true,
			-- end_row = 0,
			-- end_col = 0,
			-- end_right_gravity = true,
			-- hl_eol = true,
			-- hl_group = "Visual",
			-- priority = 101,
		}
	)

	local pos = vim.api.nvim_buf_get_extmark_by_id(0, M.cache.ns_id, id, {details = true})
	vim.print("save!", pos)

	return id
end

M.load = function(id)
	local pos = vim.api.nvim_buf_get_extmark_by_id(0, M.cache.ns_id, id, {details = true})

	vim.print("load!", pos)

	vim.api.nvim_buf_del_extmark(0, M.cache.ns_id, id)
	vim.fn.cursor(pos[1] + 1, pos[2] + 1)
end

M.load_later = function(id, when)
	local load = function() M.load(id) end

	if when == "schedule" then
		vim.schedule(load)
	else
		vim.api.nvim_create_autocmd(
			"ModeChanged",
			{
				pattern = when,
				callback = load,
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
				local id = require("fix-cursor").save()
				require("fix-cursor").load_later(id, when)
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
					local id = require("fix-cursor").save()
					require("fix-cursor").load_later(id, when)
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
					local id = require("fix-cursor").save()
					require("fix-cursor").load_later(id, when)
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
					local id = require("fix-cursor").save()
					require("fix-cursor").load_later(id, when)
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
					local id = require("fix-cursor").save()
					require("fix-cursor").load_later(id, when)
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
