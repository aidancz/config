-- # mini.pick

--[=[

require("mini.pick").registry.outliner = function()
	local restore = function()
		local matches = require("mini.pick").get_picker_matches()

		local win = require("mini.pick").get_picker_state().windows.target
		-- local buf = vim.api.nvim_win_get_buf(win)
		local pos10 = vim.api.nvim_win_get_cursor(win)
		local pos00 = {
			pos10[1] - 1,
			pos10[2],
		}

		local idx_matches = require("outliner").pos_get_heading_idx(matches.all, pos00)
		if idx_matches == nil then return end

		local idx_items = matches.all_inds[idx_matches]
		-- vim.print({matches.all_inds, idx_items})
		require("mini.pick").set_picker_match_inds({idx_items}, "current")
	end

	local buf = vim.api.nvim_get_current_buf()
	local headings = require("outliner").buf_list_headings(buf)
	local indent_default = string.rep("\t", 0)
	for _, i in ipairs(headings) do
		local indent_level = string.match(i.name, "^h(%d)$")
		if indent_level == nil then
			indent         = indent_default
			indent_default = indent_default
		else
			indent         = string.rep("\t", indent_level - 1)
			indent_default = string.rep("\t", indent_level)
		end
		i.text = string.format(
			"@%-16s %s%s",
			i.name,
			indent,
			i.node_text
		)
		i.buf = i.buf
		i.lnum     = i.row1 + 1
		i.col      = i.col1 + 1
		i.end_lnum = i.row2 + 1
		i.end_col  = i.col2 + 1
	end

	vim.api.nvim_create_autocmd(
		"User",
		{
			pattern = "MiniPickStart",
			callback = restore,
			once = true,
		}
	)
	local id = vim.api.nvim_create_autocmd(
		"User",
		{
			pattern = "MiniPickMatch",
			callback = restore,
		}
	)

	require("mini.pick").start({
		mappings = {
			restore = {
				char = "<c-r>",
				func = restore,
			},
			set = {
				char = "<c-s>",
				func = function()
					local matches = require("mini.pick").get_picker_matches()
					local state = require("mini.pick").get_picker_state()
					vim.api.nvim_win_set_cursor(
						state.windows.target,
						{
							matches.current.lnum,
							matches.current.col - 1,
						}
					)
					vim.api.nvim_win_call(
						state.windows.target,
						function()
							vim.cmd("normal zz")
						end
					)
					return false
				end,
			},
		},
		source = {
			items = headings,
			match = function(stritems, inds, query)
				return
				require("mini.pick").default_match(
					stritems,
					inds,
					query,
					{
						preserve_order = true,
					}
				)
			end,
			-- choose = function(item)
			-- end,
		},
	})

	vim.api.nvim_del_autocmd(id)
end

require("luaexec").add({
	code = [[require("mini.pick").registry.outliner()]],
	from = "mini.pick",
	keys = {"n", "fo"},
})

--]=]
