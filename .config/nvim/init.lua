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

-- # ui2

-- affect vim.api.nvim_list_wins: https://github.com/neovim/neovim/issues/34295
-- affect <c-f>/<c-b> since there are many floating windows (:h ctrl-f)

require("vim._core.ui2").enable({
	enable = true,
	msg = {
		target = "cmd",
		-- target = "msg",
		timeout = 4000,
	},
})

-- # setup vim.pack

require("pack")

-- # define load helpers (steal from mini.misc)

-- vim.pack.add({
-- 	"https://github.com/nvim-mini/mini.misc",
-- })
-- local safely = require("mini.misc").safely
-- local now = function(f) safely("now", f) end
-- local later = function(f) safely("later", f) end
-- local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- local call = function(f, init_trace)
-- 	local ok, res = pcall(f)
-- 	if ok then return end
-- 	vim.notify(res, vim.log.levels.ERROR)
-- 	vim.notify(debug.traceback(), vim.log.levels.TRACE)
-- 	vim.notify(init_trace, vim.log.levels.TRACE)
-- end
-- local now = function(f)
-- 	call(f, "")
-- end
-- local queue = {}
-- local process_queue = function()
-- 	local timer = vim.uv.new_timer()
-- 	local empty_queue
-- 	empty_queue = vim.schedule_wrap(function()
-- 		local cb = queue[1]
-- 		if cb == nil then
-- 			timer:close()
-- 			return
-- 		end
-- 		table.remove(queue, 1)
-- 		call(cb.f, cb.trace)
-- 		timer:start(1, 0, empty_queue)
-- 	end)
-- 	timer:start(1, 0, empty_queue)
-- end
-- local later = function(f)
-- 	if vim.tbl_isempty(queue) then
-- 		vim.schedule(process_queue)
-- 	end
-- 	table.insert(queue, {f = f, trace = debug.traceback()})
-- end

local now = function(f)
	local ok, res = pcall(f)
	if ok then return end
	vim.notify(res, vim.log.levels.ERROR)
	-- vim.notify(debug.traceback(), vim.log.levels.TRACE)
end
local later = function(f)
	vim.schedule(function()
		now(f)
	end)
end

-- # require now

do

	-- # redefine `require` function

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

	-- require("_test")

end

-- # require later

do

	-- # redefine `require` function

	local original_require = require
	local require = function(modname) later(function() original_require(modname) end) end

	-- # library

	-- require("_mini-pick")
	require("_fzf-lua")
	require("_telescope")

	-- # main

	-- require("_Comment")
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
	require("_auto-save")
	require("_blink-cmp")
	require("_conform")
	require("_fcitx")
	require("_friendly-snippets")
	require("_fzf-lua__enchanted-files")
	require("_fzf-lua__frecency")
	require("_fzf-lua__luaexec")
	require("_fzf-lua__outliner")
	require("_lazygit")
	require("_lfsp")
	require("_macro")
	require("_markdown-preview")
	require("_marks")
	require("_mini-ai")
	require("_mini-align")
	require("_mini-bufremove")
	require("_mini-comment")
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
	require("_operator")
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

	-- require("_fix-cursor") -- too hacky and fragile

	-- require("_test")

end
