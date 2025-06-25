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

	opts = vim.tbl_deep_extend(
		"force",
		{
			fzf_opts = {
				["--delimiter"] = string.format("[%s]", require("fzf-lua").utils.nbsp),
				["--with-nth"] = "5..",
				["--no-sort"] = true,
			},
			actions = {
				["default"] = function(selected, opts)
					local components = vim.split(selected[1], require("fzf-lua").utils.nbsp)
					local buf = tonumber(components[2])
					local row1 = tonumber(components[3])
					local col1 = tonumber(components[4])
					vim.api.nvim_win_set_cursor(0, {row1 + 1, col1})
					vim.cmd("normal! zz")
				end,
				["load,change"] = {
					exec_silent = true,
					fn = function(selected, opts)
					end,
				}
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
	keys = {"n", "ro"},
})
