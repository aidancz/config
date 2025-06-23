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
