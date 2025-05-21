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
(tag text: (word) @tag)
]]
)

M.query_registry.lua = vim.treesitter.query.parse(
	"lua",
[[
(chunk (comment) @comment)
(chunk (assignment_statement) @assign)
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

M.list_headings = function()
	local headings = {}

	local buf = vim.api.nvim_get_current_buf()
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

return M
