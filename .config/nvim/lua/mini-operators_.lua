vim.pack.add({
	"https://github.com/nvim-mini/mini.operators",
})

require("mini.operators").setup({
	evaluate = {
		prefix = "<space>=",
	},
	exchange = {
		prefix = "<space>x",
	},
	multiply = {
	-- 2 counts, see comment below
		prefix = "t",
	},
	replace = {
	-- 2 counts, see comment below
		prefix = "x",
		reindent_linewise = false,
	},
	sort = {
		prefix = "<space>o",
	},
})

-- 2 counts
--
-- :h motion-count-multiplied
-- if the motion includes a count and the operator also had a count before it,
-- the two counts are multiplied. for example: "2d3w" deletes six words.
--
-- however, mini.operators uses a special trick so that the two counts are no longer multiplied together and instead carry different meanings
