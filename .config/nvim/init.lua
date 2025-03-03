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



-- # global settings need to be set very first

require("variable")
require("option")



-- # global settings need to be set first

require("_nofrils")
require("diagnostic")
require("keymap")
require("statusline")



-- # ui stable

-- require("_mini-trailspace")
require("_buvvers")
require("_eolmark")
require("_outline_HACK1")
require("_whitespace")



-- # contains BufEnter autocmd

require("_go-up")
require("_guess-indent")
require("_markdown-preview")
require("_nvim-lspconfig")
require("autocmd")



end)

----------------------------------------------------------------

require("mini.deps").later(function()



-- # library

require("_plenary")
require("_mini-extra")



-- # main

-- require("_LuaSnip")
-- require("_NeoComposer")
-- require("_aerial")
-- require("_bufferline")
-- require("_gitsigns")
-- require("_indent-blankline")
-- require("_lualine")
-- require("_mini-comment")
-- require("_mini-icons")
-- require("_mini-notify")
-- require("_mini-statusline")
-- require("_neo-tree")
-- require("_nvim-better-n")
-- require("_nvim-cmp")
-- require("_nvim-ghost")
-- require("_nvim-next")
-- require("_nvim-recorder")
-- require("_nvim-spider")
-- require("_nvim-surround")
-- require("_nvim-ufo")
-- require("_sidebar")
-- require("_sniprun")
-- require("_undotree-mbbill")
-- require("_vim-ReplaceWithRegister")
-- require("_vim-suda")
-- require("_vuffers")
require("_Comment")
require("_blink-cmp")
require("_fcitx")
require("_fidget")
require("_fzf-lua")
require("_lfsp")
require("_marks")
require("_mini-ai")
require("_mini-align")
require("_mini-bracketed")
require("_mini-bufremove")
require("_mini-deps")
require("_mini-diff")
require("_mini-indentscope")
require("_mini-move")
require("_mini-operators")
require("_mini-snippets")
require("_mini-splitjoin")
require("_mini-surround")
require("_nvim-colorizer")
require("_nvim-treesitter")
require("_nvim-treesitter-textobjects")
require("_outline")
require("_outline_HACK2")
require("_paramo")
require("_sentiment")
require("_tT")
require("_telescope")
require("_undotree-jiaoshijie")
require("_vim-mark")
require("_vim-table-mode")
require("_yazi")
require("macro")
require("redir")



end)

----------------------------------------------------------------

-- testing section

-- require("mini.deps").add({
-- 	source = "",
-- })
-- require("").setup({
-- })
