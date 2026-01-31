local M = {}

-- # query_registry

M.query_registry = {
--[[
	lang1 = vim.treesitter.Query1,
	lang2 = vim.treesitter.Query2,
	...
--]]
}

M.query_registry.vimdoc = vim.treesitter.query.parse(
	"vimdoc",
[[
(h1 (heading) @h1)
(h2 (heading) @h2)
(h3 (heading) @h3)
(line (column_heading) @subheading)
(tag text: (word) @tag)
]]
)

M.query_registry.markdown = vim.treesitter.query.parse(
	"markdown",
[[
(atx_heading (atx_h1_marker) heading_content: (_) @h1)
(atx_heading (atx_h2_marker) heading_content: (_) @h2)
(atx_heading (atx_h3_marker) heading_content: (_) @h3)
(atx_heading (atx_h4_marker) heading_content: (_) @h4)
(atx_heading (atx_h5_marker) heading_content: (_) @h5)
(atx_heading (atx_h6_marker) heading_content: (_) @h6)
]]
)

M.query_registry.lua = vim.treesitter.query.parse(
	"lua",
[[
(chunk (comment) @h1 (#match? @h1 "^-- # "))
(chunk (comment) @h2 (#match? @h2 "^-- ## "))
(chunk (comment) @h3 (#match? @h3 "^-- ### "))
(chunk (comment) @h4 (#match? @h4 "^-- #### "))
(chunk (variable_declaration
  [
    (variable_list) @variable
    (assignment_statement (variable_list) @variable)
  ]))
(chunk (assignment_statement (variable_list) @variable))
(chunk (function_call name: (_) @function))
]]
)

M.query_registry.bash = vim.treesitter.query.parse(
	"bash",
[[
((comment) @h1 (#match? @h1 "^# \\* "))
((comment) @h2 (#match? @h2 "^# \\*\\* "))
((comment) @h3 (#match? @h3 "^# \\*\\*\\* "))
((comment) @h4 (#match? @h4 "^# \\*\\*\\*\\* "))
]]
)

M.query_registry.xresources = vim.treesitter.query.parse(
	"xresources",
[[
((comment) @h1 (#match? @h1 "^! # "))
((comment) @h2 (#match? @h2 "^! ## "))
((comment) @h3 (#match? @h3 "^! ### "))
((comment) @h4 (#match? @h4 "^! #### "))
]]
)

M.query_registry.vim = vim.treesitter.query.parse(
	"vim",
[[
((comment) @h1 (#match? @h1 "^\" # "))
((comment) @h2 (#match? @h2 "^\" ## "))
((comment) @h3 (#match? @h3 "^\" ### "))
((comment) @h4 (#match? @h4 "^\" #### "))
]]
)

-- # buf_get_query

M.buf_get_query = function(buf)
	local filetype = vim.api.nvim_get_option_value("filetype", {buf = buf})
	local lang = vim.treesitter.language.get_lang(filetype)
	local query = assert(
		M.query_registry[lang],
		string.format("(outliner) query not found: %s", lang)
	)
	return query
end

-- # buf_get_tree

M.buf_get_tree = function(buf)
	return
	vim.treesitter.get_parser(buf):parse()[1]
end

-- # main

M.buf_list_headings = function(buf)
	local headings = {}

	local query = M.buf_get_query(buf)
	local tree = M.buf_get_tree(buf)

	for id, node, metadata, match in query:iter_captures(tree:root(), 0) do
		local node_text = vim.treesitter.get_node_text(node, 0)
		local type = node:type()
		local name = query.captures[id]
		local row1, col1, row2, col2 = node:range()
		local heading = {
			node_text = node_text,
			type = type,
			name = name,
			buf = buf,
			row1 = row1,
			col1 = col1,
			row2 = row2,
			col2 = col2,
		}
		table.insert(headings, heading)
	end

	return headings
end

-- M.buf_get_cursor = function(buf)
-- 	for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 		if vim.api.nvim_win_get_buf(win) == buf then
-- 			return vim.api.nvim_win_get_cursor(win)
-- 		end
-- 	end
-- 	return vim.api.nvim_buf_get_mark(buf, [["]])
-- end

M.pos_get_heading_idx = function(headings, pos)
	if #headings == 0 then
		return nil
	elseif headings[#headings].row1 <= pos[1] then
		return #headings
	else
		table.remove(headings)
		return M.pos_get_heading_idx(headings, pos)
	end
end

return M
