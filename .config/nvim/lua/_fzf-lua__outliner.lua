require("fzf-lua").custom_outliner = function(opts)
	opts = opts or {}

	local buf = vim.api.nvim_get_current_buf()
	local headings = require("outliner").buf_list_headings(buf)

	local indent_offset = 0
	for _, i in ipairs(headings) do
		local indent
		local level = string.match(i.name, "^h(%d)$")
		if level == nil then
			indent = indent_offset
		else
			indent = level - 1
			indent_offset = indent + 1
		end
		i.indent = indent
	end

	local headings_idx = 0
	local contents = vim.tbl_map(
		function(x)
			headings_idx = headings_idx + 1
			return
			string.format(
				"%s%s%s%s%s%s%s%s@%-16s%s%s%s",
				headings_idx,
				require("fzf-lua").utils.nbsp,
				x.buf,
				require("fzf-lua").utils.nbsp,
				x.row1,
				require("fzf-lua").utils.nbsp,
				x.col1,
				require("fzf-lua").utils.nbsp,
				x.name,
				require("fzf-lua").utils.nbsp,
				string.rep("\t", x.indent),
				x.node_text
			)
		end,
		headings
	)

	local previewer = require("fzf-lua.previewer.builtin").buffer_or_file:extend()
	-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
	previewer.new = function(self, o, opts, fzf_win)
		previewer.super.new(self, o, opts, fzf_win)
		setmetatable(self, previewer)
		return self
	end
	previewer.parse_entry = function(self, entry_str)
		local components = vim.split(entry_str, require("fzf-lua").utils.nbsp)
		local buf = tonumber(components[2])
		local row1 = tonumber(components[3])
		local col1 = tonumber(components[4])
		return {
			path = vim.api.nvim_buf_get_name(buf),
			line = row1 + 1,
		}
	end

	local fzf_get_port = function()
		return "localhost:" .. vim.env.FZF_PORT
	end
	local fzf_get_state = function()
		local port = fzf_get_port()
		local json = vim.system({"curl", "-sL", port}):wait().stdout
		local state = vim.json.decode(json)
		return state
	end
	local get_matches = function()
		local state = fzf_get_state()
		local match_indexes = vim.tbl_map(
			function(x)
				return x.index + 1
			end,
			state.matches
		)
		local matches = {}
		for _, i in ipairs(match_indexes) do
			table.insert(matches, headings[i])
		end
		return matches
	end
	local nvim_get_cursor = function(win)
		local pos10 = vim.api.nvim_win_get_cursor(win)
		local pos00 = {
			pos10[1] - 1,
			pos10[2],
		}
		return pos00
	end
	local fzf_set_cursor = function(idx)
		local port = fzf_get_port()
		vim.system({
			"curl",
			"-XPOST",
			port,
			"-d",
			string.format("pos(%s)", idx)
		}):wait()
	end
	local fzf_restore_cursor = function(selected, opts)
		local matches = get_matches()
		local nvim_cursor = nvim_get_cursor(opts.__CTX.winid)
		local idx_matches = require("outliner").pos_get_heading_idx(matches, nvim_cursor)
		if idx_matches == nil then return end
		fzf_set_cursor(idx_matches)
	end
	local nvim_set_cursor = function(selected, opts)
		local components = vim.split(selected[1], require("fzf-lua").utils.nbsp)
		local buf = tonumber(components[2])
		local row1 = tonumber(components[3])
		local col1 = tonumber(components[4])

		local win = opts.__CTX.winid
		vim.api.nvim_win_set_cursor(win, {row1 + 1, col1})
		vim.api.nvim_win_call(win, function() vim.cmd("normal! zz") end)
	end

	opts = vim.tbl_deep_extend(
		"force",
		{
			fzf_opts = {
				["--delimiter"] = string.format("[%s]", require("fzf-lua").utils.nbsp),
				["--with-nth"] = "5..",
				["--read0"] = true,
				["--no-multi-line"] = true,
				["--no-sort"] = true,
				["--listen"] = 0,
			},
			keymap = {
				fzf = {
					["start"] = string.format(
						"%s+%s:%s",
						"unbind(change)", -- since FZF_DEFAULT_OPTS --bind=change:first
						"execute-silent",
						string.format(
							"nvim --server %s --remote-expr %s",
							vim.v.servername,
							[["luaeval('(function() vim.env.FZF_PORT = $FZF_PORT end)()')"]]
						)
					),
				},
			},
			actions = {
				["default"] = nvim_set_cursor,
				["result,ctrl-r"] = {
					fn = fzf_restore_cursor,
					exec_silent = true,
				},
				["ctrl-a"] = {
					fn = nvim_set_cursor,
					exec_silent = true,
				},
			},
			previewer = previewer,
		},
		opts
	)

	require("fzf-lua").fzf_exec(contents, opts)
end

require("luaexec").add({
	code = [[require("fzf-lua").custom_outliner()]],
	from = "outliner",
	keys = {"n", "so"},
})
