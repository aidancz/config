require("mini.pick").registry.outliner = function()
	local headings = require("outliner").list_headings()
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
	require("mini.pick").start({
		source = {
			items = headings,
			-- choose = function(item)
			-- end,
		},
	})
end

require("luaexec").add({
	code = [[require("mini.pick").registry.outliner()]],
	from = "mini.pick",
	gkey = {"n", "fo"},
})
