--[[

debug:

do return end
os.exit()
https://stackoverflow.com/questions/20188458/how-to-exit-a-lua-scripts-execution

vim.api.nvim_out_write(vim.fn.system({"date", "--iso-8601=ns"}))

--]]

----------------------------------------------------------------

vim.loader.enable()

----------------------------------------------------------------

local path_package = vim.fn.stdpath('data') .. '/site/'
local path_deps = path_package .. 'pack/deps/start/mini.deps'
if not vim.uv.fs_stat(path_deps) then
	vim.system(
		{
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/echasnovski/mini.deps',
			path_deps,
		}
	):wait()
	vim.cmd('packadd mini.deps')
	vim.cmd('helptags ALL')
end

require("mini.deps").setup()

----------------------------------------------------------------

require("mini.deps").now(function()

require("variable")
require("option")
require("_guess-indent")

require("keymap")

require("_nofrils")
require("_eolmark")
require("_whitespace")
require("diagnostic")
-- require("_mini-trailspace")

require("autocmd")
require("_outline_HACK1")
require("_outline_HACK2")
require("_buvvers")
require("_nvim-lspconfig")
require("_markdown-preview")
require("_go-up")

end)

----------------------------------------------------------------

require("mini.deps").later(function()

require("_plenary")
require("_mini-extra")

end)

----------------------------------------------------------------

require("mini.deps").later(function()

-- require("_gitsigns")
-- require("_indent-blankline")
-- require("_mini-icons")
-- require("_nvim-ufo")
require("_marks")
require("_mini-diff")
require("_nvim-colorizer")
require("_nvim-treesitter")
require("_nvim-treesitter-textobjects")
require("_sentiment")

-- require("_LuaSnip")
-- require("_nvim-better-n")
-- require("_nvim-ghost")
-- require("_nvim-next")
-- require("_nvim-surround")
-- require("_vim-ReplaceWithRegister")
require("_Comment")
require("_fcitx")
require("_lfsp")
require("_mini-ai")
require("_mini-align")
require("_mini-bracketed")
require("_mini-comment")
require("_mini-indentscope")
require("_mini-move")
require("_mini-operators")
require("_mini-snippets")
require("_mini-splitjoin")
require("_mini-surround")
require("_paramo")
require("_tT")
require("_vim-mark")

-- require("_bufferline")
-- require("_neo-tree")
-- require("_sidebar")
-- require("_telescope")
-- require("_undotree-mbbill")
-- require("_vim-suda")
-- require("_vuffers")
require("_fzf-lua")
require("_outline")
require("_undotree-jiaoshijie")
require("_yazi")
require("redir")

-- require("_aerial")
-- require("_nvim-cmp")
-- require("_sniprun")
require("_blink-cmp")

require("_vim-table-mode")

require("_mini-deps")

end)

----------------------------------------------------------------

-- testing section

-- require("mini.deps").add({
-- 	source = "",
-- })
-- require("").setup({
-- })
