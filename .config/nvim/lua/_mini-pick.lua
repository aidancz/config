require("mini.deps").add({
	source = "echasnovski/mini.pick",
})

require("mini.pick").gen_yank = function(item2str_or_strs)
	local func = function()
		local item = require("mini.pick").get_picker_matches().current
		local str_or_strs = item2str_or_strs(item)
		local text
		if type(str_or_strs) == "string" then
			text = str_or_strs
		elseif type(str_or_strs) == "table" then
			text = table.concat(str_or_strs, "\n") .. "\n"
		else
			return
		end
		vim.fn.setreg(vim.v.register, text)
		return true
	end
	return
	{
		char = "<c-y>",
		func = func,
	}
end

local query = {}
vim.api.nvim_create_augroup("mini_pick_config", {clear = true})
vim.api.nvim_create_autocmd(
	"User",
	{
		group = "mini_pick_config",
		pattern = "MiniPickStop",
		callback = function()
			local current_query = require("mini.pick").get_picker_query()
			if next(current_query) ~= nil then
				query = current_query
			end
		end,
	}
)
local resume_query = function()
	require("mini.pick").set_picker_query(query)
end

require("mini.pick").setup({
	mappings = {
		stop1 = {
			char = "<c-esc>",
			func = require("mini.pick").stop,
		},
		stop2 = {
			char = "<s-esc>",
			func = require("mini.pick").stop,
		},
		caret_home = {
		-- https://github.com/echasnovski/mini.nvim/issues/513#issuecomment-1764784504
			char = "<home>",
			func = function()
				local mappings = require("mini.pick").get_picker_opts().mappings
				local keys = string.rep(mappings.caret_left, 32)
				vim.api.nvim_input(keys)
			end,
		},
		caret_end = {
		-- https://github.com/echasnovski/mini.nvim/issues/513#issuecomment-1764784504
			char = "<end>",
			func = function()
				local mappings = require("mini.pick").get_picker_opts().mappings
				local keys = string.rep(mappings.caret_right, 32)
				vim.api.nvim_input(keys)
			end,
		},
		print = {
			char = "<c-=>",
			func = function()
				local items = require("mini.pick").get_picker_items()
				local stritems = require("mini.pick").get_picker_stritems()
				local matches = require("mini.pick").get_picker_matches()
				local opts = require("mini.pick").get_picker_opts()
				local state = require("mini.pick").get_picker_state()
				local query = require("mini.pick").get_picker_query()

				vim.print(query)
			end,
		},
		pick_actions = {
			char = "<c-cr>",
			func = function()
				local opts = require("mini.pick").get_picker_opts()
				local actions = vim.tbl_keys(opts.mappings)
				table.sort(actions)
				require("mini.pick").start({
					source = {
						items = actions,
						choose = function(item)
							-- <execute the chosen action in the previous picker>
						end,
					},
				})
			end,
		},
		yank = require("mini.pick").gen_yank(
			function(item)
				if type(item) == "string" then
					return item
				else
					return vim.inspect(item)
				end
			end
		),
		resume_query = {
			char = "<c-k>",
			func = resume_query,
		},
	},
	options = {
		content_from_bottom = false,
	},
	source = {
		name = "<no name>",
		preview = function(buf_id, item)
			return
			require("mini.pick").default_preview(
				buf_id,
				item,
				{
					line_position = "center",
				}
			)
		end,
	},
	window = {
		config = {
			relative = "editor",
			height   = math.floor(0.8 * vim.o.lines),
			width    = math.floor(0.8 * vim.o.columns),
			anchor   = "NW",
			row      = math.floor(0.1 * vim.o.lines)   - 1,
			col      = math.floor(0.1 * vim.o.columns) - 1,
		},
		prompt_caret = "█",
		prompt_prefix = "",
	},
})

vim.ui.select = require("mini.pick").ui_select

require("mini.pick").registry.registry = function()
	local items = vim.tbl_keys(require("mini.pick").registry)
	table.sort(items)
	require("mini.pick").start({
		source = {
			items = items,
			choose = function(item)
				require("mini.pick").registry[item]()
			end,
		},
	})
end

---@param local_opts {
---	histname: ":"|"/"|"?", -- `:h hist-names`
---}
require("mini.pick").registry.history = function(local_opts)
	local history = {}
	for i = vim.fn.histnr(local_opts.histname), 1, -1 do
		local entry = vim.fn.histget(local_opts.histname, i)
		if entry ~= "" then
			table.insert(
				history,
				{
					histnr = i,
					histname = local_opts.histname,
					entry = entry,
				}
			)
		end
	end
	for _, i in ipairs(history) do
		i.text = string.format(
			"%8s %s%s",
			i.histnr,
			i.histname,
			i.entry
		)
	end

	require("mini.pick").start({
		mappings = {
			yank = require("mini.pick").gen_yank(function(item) return item.entry end),
		},
		options = {
			content_from_bottom = true,
		},
		source = {
			items = history,
			choose = function(item)
				vim.schedule(function()
					vim.api.nvim_feedkeys(item.histname .. item.entry .. "\n", "nxt", true)
				end)
			end,
			preview = function(buf_id, item)
				local lines = {}

				vim.list_extend(lines, {tostring(item.histnr)})
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, {item.histname .. item.entry})

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
			end,
		},
	})
end

require("nofrils").clear("^MiniPick")

vim.api.nvim_set_hl(0, "MiniPickBorderBusy",    {link = "nofrils_yellow"})
vim.api.nvim_set_hl(0, "MiniPickCursor",        {link = "nofrils_transparent"})
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent",  {link = "nofrils_reverse"})
vim.api.nvim_set_hl(0, "MiniPickMatchMarked",   {link = "nofrils_blue_bg"})
vim.api.nvim_set_hl(0, "MiniPickMatchRanges",   {link = "nofrils_blue"})
vim.api.nvim_set_hl(0, "MiniPickPreviewLine",   {link = "nofrils_white_bg"})
vim.api.nvim_set_hl(0, "MiniPickPreviewRegion", {link = "nofrils_blue_bg"})

require("luaexec").add({
	code = [[require("mini.pick").registry.registry()]],
	from = "mini.pick",
	keys = {"n", "f<space>"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.resume()]],
	from = "mini.pick",
	keys = {"n", "fk"},
})

-- require("luaexec").add({
-- 	code = [[require("mini.pick").registry.files()]],
-- 	from = "mini.pick",
-- 	keys = {"n", "ff"},
-- })

require("luaexec").add({
	code =
[[
require("mini.pick").builtin.files(
	nil,
	{
		source = {
			cwd = require("mini.misc").find_root(),
		},
	}
)
]],
	from = "mini.pick",
	keys = {"n", "ff"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.buffers()]],
	from = "mini.pick",
	keys = {"n", "fb"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.help()]],
	from = "mini.pick",
	keys = {"n", "fh"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.history({histname = ":"})]],
	from = "mini.pick",
	keys = {"n", "f:"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.history({histname = "/"})]],
	from = "mini.pick",
	keys = {"n", "f/"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.history({histname = "?"})]],
	from = "mini.pick",
	keys = {"n", "f?"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.buf_lines({scope = "current"})]],
	from = "mini.pick",
	keys = {"n", "fl"},
})

require("luaexec").add({
	code = [[require("mini.pick").registry.grep_live()]],
	from = "mini.pick",
	keys = {"n", "fs"},
})

-- # luaexec

require("mini.pick").registry.luaexec_exec = function()
	local nodes = require("luaexec").list_nodes()
	for _, i in ipairs(nodes) do
		i.tag = string.format(
			"(%s%s)",
			i.from,
			i.name and (" " .. i.name) or ""
		)
		i.text = string.format(
			"%-32s %s %s",
			i.tag,
			i.code,
			i.desc or ""
		)
		setmetatable(i, nil) -- callable item will be called when: item -> stritem
	end
	require("mini.pick").start({
		mappings = {
			yank = require("mini.pick").gen_yank(function(item) return item.code end),
		},
		source = {
			items = nodes,
			-- choose = function(item)
			-- 	require("luaexec").node_exec(item, true)
			-- end,
			choose = function(item)
				vim.keymap.set(
					{"n", "x", "s", "i", "c", "t", "o"},
					"<plug>(luaexec_temp_key)",
					function()
						require("luaexec").node_exec(item, true)
					end
				)
				vim.api.nvim_create_autocmd(
					"BufEnter",
					{
						callback = vim.schedule_wrap(function()
							vim.api.nvim_input("<plug>(luaexec_temp_key)")
						end),
						once = true,
					}
				)
			end,
			preview = function(buf_id, item)
				local lines = {}

				local split = function(s)
					if s == nil or s == "" then
						return {""}
					else
						return vim.split(s, "\n", {trimempty = true})
					end
				end
				vim.list_extend(lines, split(item.tag))
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, split(item.code))
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, split(item.desc))

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
				-- vim.api.nvim_set_option_value("filetype", "lua", {buf = buf_id})
			end,
		},
	})
end

require("luaexec").add({
	code = [[require("mini.pick").registry.luaexec_exec()]],
	from = "luaexec",
	keys = {
		{{"n", "i", "c", "x", "s", "o", "t", "l"}, "<c-cr>"},
		{{"n", "x"}, "fj"},
	},
})

require("mini.pick").registry.luaexec_luaeval_history = function()
-- borrow code from `require("mini.extra").pickers.history`
	local history1 = {}
	for i = vim.fn.histnr("cmd"), 1, -1 do
		local cmd = vim.fn.histget("cmd", i)
		if cmd ~= "" then
			table.insert(
				history1,
				{
					histnr = i,
					cmd = cmd,
				}
			)
		end
	end
	local history2 = {}
	for _, i in ipairs(history1) do
		local code_tbl = require("luaexec").cmd2code(i.cmd)
		if code_tbl then
			i.code_tbl = code_tbl
			table.insert(history2, i)
		end
	end
	for _, i in ipairs(history2) do
		i.text = string.format(
			"%8s %s",
			i.histnr,
			table.concat(i.code_tbl, "\n")
		)
	end

	-- local timer = vim.uv.new_timer()
	-- timer:start(
	-- 	0,
	-- 	2,
	-- 	function()
	-- 		local picker_state = require("mini.pick").get_picker_state()
	-- 		if
	-- 			picker_state
	-- 			and
	-- 			not picker_state.is_busy
	-- 		then
	-- 			timer:stop()
	-- 			vim.api.nvim_input("\t")
	-- 		end
	-- 	end
	-- )

	vim.api.nvim_create_autocmd(
		"User",
		{
			pattern = "MiniPickStart",
			callback = function()
				vim.api.nvim_input("\t")
			end,
			once = true,
		}
	)
	-- i am the smartest human on the planet, okay, okay...

	require("mini.pick").start({
		mappings = {
			yank = require("mini.pick").gen_yank(function(item) return item.code_tbl end),
		},
		options = {
			content_from_bottom = true,
		},
		source = {
			items = history2,
			choose = function(item)
				require("luaeval").buf_set_lines(item.code_tbl)
				vim.schedule(function()
					require("luaeval").open()
				end)
			end,
			preview = function(buf_id, item)
				local lines = {}

				vim.list_extend(lines, {tostring(item.histnr)})
				vim.list_extend(lines, {"■"})
				vim.list_extend(lines, item.code_tbl)

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, lines)
			end,
		},
	})
end

require("luaexec").add({
	code = [[require("mini.pick").registry.luaexec_luaeval_history()]],
	from = "mini.pick",
	keys = {"n", "f<up>"},
})
