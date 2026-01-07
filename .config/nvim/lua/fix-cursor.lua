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

---@param opts? {
---	right_gravity?: boolean, @default false
---}
M.save = function(opts)
	opts = vim.tbl_extend(
		"force",
		{
			right_gravity = false,
			-- end_row = 0,
			-- end_col = 0,
			-- end_right_gravity = true,
			-- hl_eol = true,
			-- hl_group = "Visual",
			-- priority = 101,
		},
		opts or {}
	)

	local id = vim.api.nvim_buf_set_extmark(
		0,
		M.cache.ns_id,
		vim.fn.line(".") - 1,
		vim.fn.col(".") - 1,
		opts
	)

	local pos = vim.api.nvim_buf_get_extmark_by_id(0, M.cache.ns_id, id, {details = true})
	vim.print("save: " .. vim.inspect(pos, {newline = "", indent = ""}))

	return id
end

M.load = function(id)
	local pos = vim.api.nvim_buf_get_extmark_by_id(0, M.cache.ns_id, id, {details = true})

	vim.print("load: " .. vim.inspect(pos, {newline = "", indent = ""}))

	vim.api.nvim_buf_del_extmark(0, M.cache.ns_id, id)
	vim.fn.cursor(pos[1] + 1, pos[2] + 1)
end

--[[
with:
--]]

require("vim._extui").enable({
	enable = true,
	msg = {
		-- target = "cmd",
		target = "msg",
		timeout = 4000,
	},
})
vim.api.nvim_create_autocmd(
	"ModeChanged",
	{
		callback = function(event)
			print(event.match)
		end,
	}
)

--[[
key: y<esc>
print:
	n:no
	no:n

key: yiw (built-in textobject "iw")
print:
	n:no
	no:n

key: yiw (mini.ai textobject "iw")
print:
	n:no
	no:n
	n:v
	v:n

key: c<esc>
print:
	n:no
	no:n

key: ciw...<esc> (built-in textobject "iw")
print:
	n:no
	no:i
	i:n

key: ciw...<esc> (mini.ai textobject "iw")
print:
	n:no
	no:n
	n:v
	v:i
	i:n
--]]

M.load_later = function(id, when)
	local load = function() M.load(id) end
	local load_schedule_and_checkmode = vim.schedule_wrap(function()
		vim.print("schedule start!")
		local mode = vim.api.nvim_get_mode().mode
		if mode ~= "n" then
			vim.api.nvim_create_autocmd(
				"ModeChanged",
				{
					pattern = "*:n",
					callback = load,
					once = true,
				}
			)
		else
			load()
		end
	end)

	if when == "schedule" then
		load_schedule_and_checkmode()
	else
		vim.api.nvim_create_autocmd(
			"ModeChanged",
			{
				pattern = when,
				callback = load_schedule_and_checkmode,
				once = true,
			}
		)
	end
end

---@param opts? {
---	right_gravity?: boolean, @default false
---}
M.wrap = function(key, when, opts)
	opts = vim.tbl_extend("force", {right_gravity = false}, opts or {})

	local dict = vim.fn.maparg(key, "n", false, true)

	if vim.tbl_isempty(dict) then
		vim.keymap.set(
			"n",
			key,
			function()
				local id = require("fix-cursor").save(opts)
				require("fix-cursor").load_later(id, when)
				return key
			end,
			{
				expr = true,
				replace_keycodes = true,
				remap = false,
			}
		)
		return
	end

	local expr
	if dict.expr == 0 then expr = false else expr = true end

	local replace_keycodes
	if dict.replace_keycodes == 1 then replace_keycodes = true else replace_keycodes = false end
	-- NOTE: replace_keycodes is valid only when expr is true
	-- before https://github.com/neovim/neovim/pull/37272: true: 1 false: nil
	-- after  https://github.com/neovim/neovim/pull/37272: true: 1 false: 0
	-- so we use "== 1" here

	local remap
	if dict.noremap == 0 then remap = true else remap = false end

	if dict.rhs ~= nil then
		local rhs = dict.rhs

		if expr == false then
			vim.keymap.set(
				"n",
				key,
				function()
					local id = require("fix-cursor").save(opts)
					require("fix-cursor").load_later(id, when)
					return rhs
				end,
				{
					expr = true,
					replace_keycodes = true,
					remap = remap,
				}
			)
		else
			vim.keymap.set(
				"n",
				key,
				function()
					local id = require("fix-cursor").save(opts)
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
		local callback = dict.callback

		if expr == false then
			vim.keymap.set(
				"n",
				key,
				function()
					local id = require("fix-cursor").save(opts)
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
					local id = require("fix-cursor").save(opts)
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
