----------------------------------------------------------------

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

MiniDeps.now(function()

require("variable")
require("option")

require("_nofrils")

require("autocmd")
require("_eolmark")

end)

----------------------------------------------------------------

MiniDeps.later(function()

require("_plenary")
require("_mini-extra")

-- require("_gitsigns")
-- require("_indent-blankline")
-- require("_mini-icons")
-- require("_nvim-ufo")
require("_marks")
require("_mini-diff")
require("_nvim-colorizer")
require("_nvim-treesitter")
require("_sentiment")

-- require("_LuaSnip")
-- require("_nvim-better-n")
-- require("_nvim-next")
-- require("_nvim-surround")
-- require("_vim-ReplaceWithRegister")
require("_Comment")
require("_fcitx")
require("_mini-ai")
require("_mini-align")
require("_mini-bracketed")
require("_mini-move")
require("_mini-operators")
require("_mini-surround")
require("_paramo")
require("_vim-mark")
require("keymap")
require("lfsp")
require("tT")
require("xX")

-- require("_telescope")
-- require("_undotree-mbbill")
-- require("_vim-suda")
-- require("_yazi")
require("_fzf-lua")
require("_undotree-jiaoshijie")
require("redir")

-- require("_nvim-lspconfig")
-- require("_outline")
-- require("_sniprun")
require("_aerial")
require("_nvim-cmp")

require("_markdown-preview")
require("_vim-table-mode")

end)

-- https://www.reddit.com/r/neovim/comments/1fltduc/better_mappings_for_the_n_and_p_keys/

----------------------------------------------------------------
