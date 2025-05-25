--[[

-- # exit lua execution

do return end
os.exit()
-- https://stackoverflow.com/questions/20188458/how-to-exit-a-lua-scripts-execution

-- # print timestamp

print(os.time())
print(os.date())
vim.notify(vim.system({"date", "--iso-8601=ns"}):wait().stdout)

--]]

----------------------------------------------------------------

vim.loader.enable()

require("vim._extui").enable({
	msg = {
		pos = "cmd",
		-- box = {
		-- 	timeout = 4000,
		-- },
	},
})

----------------------------------------------------------------

local path_package = vim.fn.stdpath("data") .. "/site/"
local path_deps = path_package .. "pack/deps/start/mini.deps"
if not vim.uv.fs_stat(path_deps) then
	vim.system(
		{
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/echasnovski/mini.deps",
			path_deps,
		}
	):wait()
	vim.cmd("packadd mini.deps")
	vim.cmd("helptags ALL")
end

require("mini.deps").setup()

require("_mini-deps")

----------------------------------------------------------------

local original_require = require

----------------------------------------------------------------

-- # redefine `require` function

local require = function(modname)
	original_require("mini.deps").now(function()
		original_require(modname)
	end)
end

-- # global variable

require("vim_global_variable")
require("option")

-- # library

require("_luaeval")
require("_mini-extra")
require("_mini-icons")
require("_mini-misc")
require("_luaexec")
require("_plenary")
require("_virtcol")

-- # ui stable

-- require("_eolmark")
-- require("_mini-starter")
-- require("_mini-tabline")
-- require("_mini-trailspace")
-- require("_outline_HACK1")
require("_buvvers")
require("_nofrils")
require("_whitespace")
require("statusline")

-- # autocmd
-- https://github.com/echasnovski/mini.nvim/issues/1378

require("_go-up")
require("_guess-indent")
require("_nvim-fundo")
require("_nvim-lspconfig")
require("autocmd")

----------------------------------------------------------------

-- # redefine `require` function

local require = function(modname)
	original_require("mini.deps").later(function()
		original_require(modname)
	end)
end

-- # main

-- require("_LuaSnip")
-- require("_NeoComposer")
-- require("_aerial")
-- require("_auto-cmdheight")
-- require("_bufferline")
-- require("_fidget")
-- require("_gitsigns")
-- require("_harpoon")
-- require("_indent-blankline")
-- require("_lualine")
-- require("_mini-bracketed")
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
-- require("_outline")
-- require("_outline_HACK2")
-- require("_sidebar")
-- require("_sniprun")
-- require("_undotree-jiaoshijie")
-- require("_vim-ReplaceWithRegister")
-- require("_vim-mark")
-- require("_vim-suda")
-- require("_vuffers")
-- require("_zen-mode")
-- require("guicursor")
-- require("redir")
require("_Comment")
require("_auto-save")
require("_blink-cmp")
require("_comment-multiply")
require("_conform")
require("_friendly-snippets")
require("_fzf-lua")
require("_hl")
require("_hls")
require("_lfsp")
require("_macro")
require("_markdown-preview")
require("_marks")
require("_mini-ai")
require("_mini-align")
require("_mini-bufremove")
require("_mini-clue")
require("_mini-comment")
require("_mini-diff")
require("_mini-indentscope")
require("_mini-keymap")
require("_mini-move")
require("_mini-operators")
require("_mini-pick")
require("_mini-snippets")
require("_mini-splitjoin")
require("_mini-surround")
require("_nvim-bqf")
require("_nvim-colorizer")
require("_nvim-treesitter") -- slow
require("_nvim-treesitter-textobjects")
require("_outliner")
require("_paramo")
require("_quicker")
require("_sentiment")
require("_snacks")
require("_substitute")
require("_tT")
require("_telescope")
require("_text-case")
require("_undotree-mbbill")
require("_vim-AdvancedSorters")
require("_vim-table-mode")
require("_virtualedit_all")
require("_yanky")
require("_yazi")
require("diagnostic")
require("hl")
require("keymap")
require("virtualedit_all")

----------------------------------------------------------------

local require = original_require

----------------------------------------------------------------

-- testing section

-- require("mini.deps").add({
-- 	source = "",
-- })
-- require("").setup({
-- })
