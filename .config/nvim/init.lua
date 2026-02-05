-- # lua debug

-- ## exit lua execution

-- https://stackoverflow.com/questions/20188458/how-to-exit-a-lua-scripts-execution

	-- do return end
	-- os.exit()

-- ## print timestamp

	-- print(os.time())
	-- print(os.date())
	-- vim.notify(vim.system({"date", "--iso-8601=ns"}):wait().stdout)

_G.get_time = function()
-- https://github.com/neovim/neovim/issues/4433
	local second, microsecond = vim.uv.gettimeofday()
	local second_format = os.date("%Y-%m-%d %H:%M:%S", second)
	local microsecond_format = string.format("%06d", microsecond)
	local time = second_format .. " " .. microsecond_format
	return time
end
_G.print_time = function()
	print(get_time())
end

	-- print_time()

-- # compile the lua modules to bytecode, improve startup time

vim.loader.enable()
-- https://github.com/lewis6991/impatient.nvim

-- # load

-- ## require pack to setup vim.pack

require("pack")

-- ## require mini.deps for its `now` and `later` functions

require("_mini-deps")

-- ## require now

do

	-- # redefine `require` function

	local now = require("mini.deps").now
	local original_require = require
	local require = function(modname) now(function() original_require(modname) end) end

	-- # global variable

	require("_nofrils")
	-- require("_catppuccin")
	require("option")
	require("vim_runtime")

	-- # library

	require("_hydra")
	require("_luaeval")
	require("_luaexec")
	require("_mini-extra")
	require("_mini-icons")
	require("_mini-misc")
	require("_plenary")

	-- # pain to live without

	require("keymap")

	-- # ui

	-- require("_eolmark")
	-- require("_mini-starter")
	-- require("_mini-tabline")
	-- require("_mini-trailspace")
	-- require("_outline_HACK1")
	require("_buvvers")
	require("_whitespace")
	require("extui")
	require("statusline")

	-- # autocmd
	-- https://github.com/nvim-mini/mini.nvim/issues/1378

	-- require("_nvim-lspconfig")
	require("_go-up")
	require("_guess-indent")
	require("_nvim-fundo")
	require("autocmd")
	require("gutter")
	require("lsp")

end

-- ## require later

do

	-- # redefine `require` function

	local later = require("mini.deps").later
	local original_require = require
	local require = function(modname) later(function() original_require(modname) end) end

	-- # library

	-- require("_mini-pick")
	require("_fzf-lua")
	require("_telescope")

	-- # main

	-- require("_LuaSnip")
	-- require("_NeoComposer")
	-- require("_aerial")
	-- require("_atone")
	-- require("_auto-cmdheight")
	-- require("_bufferline")
	-- require("_fidget")
	-- require("_fzfx")
	-- require("_gitsigns")
	-- require("_harpoon")
	-- require("_indent-blankline")
	-- require("_lualine")
	-- require("_mini-bracketed")
	-- require("_mini-clue")
	-- require("_mini-comment")
	-- require("_mini-notify")
	-- require("_mini-pick__luaexec")
	-- require("_mini-pick__outliner")
	-- require("_mini-statusline")
	-- require("_neo-tree")
	-- require("_nvim-better-n")
	-- require("_nvim-bqf")
	-- require("_nvim-cmp")
	-- require("_nvim-colorizer")
	-- require("_nvim-ghost")
	-- require("_nvim-next")
	-- require("_nvim-recorder")
	-- require("_nvim-spider")
	-- require("_nvim-surround")
	-- require("_nvim-ufo")
	-- require("_outline")
	-- require("_outline_HACK2")
	-- require("_quicker")
	-- require("_sidebar")
	-- require("_snacks")
	-- require("_sniprun")
	-- require("_tT")
	-- require("_undotree-jiaoshijie")
	-- require("_vim-ReplaceWithRegister")
	-- require("_vim-mark")
	-- require("_vim-suda")
	-- require("_vuffers")
	-- require("_which-key")
	-- require("_zen-mode")
	-- require("guicursor")
	-- require("redir")
	require("_Comment")
	require("_auto-save")
	require("_blink-cmp")
	require("_comment-multiply")
	require("_conform")
	require("_fcitx")
	require("_friendly-snippets")
	require("_fzf-lua__enchanted-files")
	require("_fzf-lua__frecency")
	require("_fzf-lua__luaexec")
	require("_fzf-lua__outliner")
	require("_hl")
	require("_hls")
	require("_lazygit")
	require("_lfsp")
	require("_macro")
	require("_markdown-preview")
	require("_marks")
	require("_mini-ai")
	require("_mini-align")
	require("_mini-bufremove")
	require("_mini-diff")
	require("_mini-hipatterns")
	require("_mini-indentscope")
	require("_mini-keymap")
	require("_mini-move")
	require("_mini-operators")
	require("_mini-snippets")
	require("_mini-splitjoin")
	require("_mini-surround")
	require("_mini-visits")
	require("_nvim-treesitter") -- slow
	require("_nvim-treesitter-textobjects")
	require("_paramo")
	require("_sentiment")
	require("_substitute")
	require("_text-case")
	require("_toggleterm")
	require("_undotree-mbbill")
	require("_vim-AdvancedSorters")
	require("_vim-table-mode")
	require("_yanky")
	require("_yazi")
	require("autoindent")
	require("diagnostic")
	require("hl")

	-- require("_fix-cursor") -- too hacky and fragile

	-- require("_test")

end
