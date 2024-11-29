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

require("_plenary")

----------------------------------------------------------------

require("plugin-builtin")

require("option")

require("keymap")
require("tT")
require("lfsp")
require("xX")

require("autocmd")
require("eolmark")

require("redir")

----------------------------------------------------------------

require("_nofrils")

require("_nvim-treesitter")

require("_sentiment")
-- require("_indent-blankline")
require("_vim-mark")
require("_nvim-colorizer")
-- require("_gitsigns")



require("_paramo")
-- require("_nvim-better-n")
-- require("_nvim-next")
-- https://www.reddit.com/r/neovim/comments/1fltduc/better_mappings_for_the_n_and_p_keys/

-- require("_undotree-mbbill")
require("_undotree-jiaoshijie")

require("_marks")

-- require("_nvim-ufo")

-- require("_vim-ReplaceWithRegister")
-- require("_nvim-surround")
require("_Comment")

require("_mini-extra")
require("_mini-ai")
require("_mini-align")
require("_mini-bracketed")
require("_mini-diff")
require("_mini-icons")
require("_mini-move")
require("_mini-operators")
require("_mini-surround")

-- require("_LuaSnip")



require("_nvim-cmp")

-- require("_vim-suda")
require("_fcitx")



-- require("_nvim-lspconfig")

-- require("_outline")
require("_aerial")

-- require("_sniprun")

require("_markdown-preview")
require("_vim-table-mode")



require("_telescope")
require("_fzf-lua")
require("_yazi")
