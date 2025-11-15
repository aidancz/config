require("fzf-lua").custom_luaexec_exec = function(opts)
	opts = opts or {}

	local nodes = require("luaexec").list_nodes()

	local contents = vim.tbl_map(
		function(x)
			return
			string.format(
				"%s%s%s%s%-32s%s%s%s%s%s%s",
				x.from,
				require("fzf-lua").utils.nbsp,
				x.name,
				require("fzf-lua").utils.nbsp,
				string.format(
					"(%s %s)",
					x.from,
					x.name
				),
				require("fzf-lua").utils.nbsp,
				x.code,
				require("fzf-lua").utils.nbsp,
				x.desc,
				require("fzf-lua").utils.nbsp,
				vim.inspect(
					x.keys,
					{
					}
				)
			)
		end,
		nodes
	)

	local previewer = require("fzf-lua.previewer.builtin").base:extend()
	-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
	previewer.new = function(self, o, opts, fzf_win)
		previewer.super.new(self, o, opts, fzf_win)
		setmetatable(self, previewer)
		return self
	end
	previewer.populate_preview_buf = function(self, entry_str)
		local components = vim.split(entry_str, require("fzf-lua").utils.nbsp)
		local lines = {}
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[3]))
		vim.list_extend(lines, {""})
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[4]))
		vim.list_extend(lines, {""})
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[5]))
		vim.list_extend(lines, {""})
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[6]))

		local tmpbuf = self:get_tmp_buffer()
		vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, true, lines)
		self:set_preview_buf(tmpbuf)
		self.win:update_preview_scrollbar()
	end
	previewer.gen_winopts = function(self)
		return
		vim.tbl_extend(
			"force",
			self.winopts,
			require("fzf-lua").form_feed_options_hack
		)
	end

	opts = vim.tbl_deep_extend(
		"force",
		{
			fzf_opts = {
				["--delimiter"] = string.format("[%s]", require("fzf-lua").utils.nbsp),
				["--with-nth"] = "3..",
				["--read0"] = true,
				["--no-multi-line"] = true,
			},
			actions = {
				["default"] = function(selected, opts)
					local node = selected[1]
					local iter = vim.gsplit(node, require("fzf-lua").utils.nbsp)
					-- can also use vim.split
					local from = iter()
					local name = iter()
					name = tonumber(name) or name
					vim.keymap.set(
						{"n", "x", "s", "i", "c", "t", "o"},
						"<plug>(luaexec_temp_key)",
						function()
							require("luaexec").registry[from][name]({histadd = true})
						end
					)
					vim.schedule(function()
						vim.api.nvim_input("<plug>(luaexec_temp_key)")
					end)
				end,
			},
			previewer = previewer,
		},
		opts
	)

	require("fzf-lua").fzf_exec(contents, opts)
end

require("luaexec").add({
	code = [[require("fzf-lua").custom_luaexec_exec()]],
	from = "luaexec",
	keys = {
		{{"n", "x"}, "e<cr>"},
		{{"n", "x", "s", "i", "c", "t", "o"}, "<f2>e<cr>"},
	},
})

require("fzf-lua").custom_luaexec_hist = function(opts)
	opts = opts or {}

	local history = require("luaexec").list_history()

	local contents = vim.tbl_map(
		function(x)
			return
			string.format(
				"%8s%s%s",
				x.histnr,
				require("fzf-lua").utils.nbsp,
				table.concat(x.code_tbl, "\n")
			)
		end,
		history
	)

	local previewer = require("fzf-lua.previewer.builtin").base:extend()
	-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
	previewer.new = function(self, o, opts, fzf_win)
		previewer.super.new(self, o, opts, fzf_win)
		setmetatable(self, previewer)
		return self
	end
	previewer.populate_preview_buf = function(self, entry_str)
		local components = vim.split(entry_str, require("fzf-lua").utils.nbsp)
		local lines = {}
		vim.list_extend(lines, require("fzf-lua").helpfunc_split(components[2]))

		local tmpbuf = self:get_tmp_buffer()
		vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, true, lines)
		self:set_preview_buf(tmpbuf)
		self.win:update_preview_scrollbar()
	end

	opts = vim.tbl_deep_extend(
		"force",
		{
			fzf_opts = {
				["--layout"] = "default",
				["--read0"] = true,
				["--no-multi-line"] = true,
			},
			actions = {
				["default"] = function(selected, opts)
					local components = vim.split(selected[1], require("fzf-lua").utils.nbsp)
					local lines = require("fzf-lua").helpfunc_split(components[2])
					require("luaeval").buf_set_lines(lines)
					require("luaeval").open()
				end,
			},
			previewer = previewer,
		},
		opts
	)

	require("fzf-lua").fzf_exec(contents, opts)
end

require("luaexec").add({
	code = [[require("fzf-lua").custom_luaexec_hist()]],
	from = "luaexec",
	keys = {"n", "e<up>"},
})
