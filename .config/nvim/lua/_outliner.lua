require("mini.pick").registry.outliner = function()
	local headings = require("outliner").list_headings()
	for _, i in ipairs(headings) do
		i.text = string.format(
			"@%-16s %s",
			i.name,
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
	gkey = {"n", "fk"},
})
