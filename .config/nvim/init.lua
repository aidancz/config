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

	require("nofrils")
	-- require("catppuccin_")
	require("option")
	require("vim_runtime")

	-- # library

	require("hydra_")
	require("luaeval_")
	require("luaexec_")
	require("mini-extra_")
	require("mini-icons_")
	require("mini-misc_")
	require("plenary_")

	-- # pain to live without

	require("keymap")

	-- # ui

	-- require("eolmark_")
	-- require("mini-starter_")
	-- require("mini-tabline_")
	-- require("mini-trailspace_")
	-- require("_outline_HACK1")
	-- require("yanky_") -- cursor flicker when lazy loading
	require("buvvers_")
	require("whitespace_")
	require("statusline")

	-- # autocmd
	-- https://github.com/nvim-mini/mini.nvim/issues/1378

	-- require("nvim-lspconfig_")
	require("go-up_")
	require("guess-indent_")
	require("gutter_")
	require("nvim-fundo_") -- https://github.com/neovim/neovim/pull/36262
	require("autocmd")
	require("lsp")

	-- # plugin/**/*.{vim,lua}
	-- :h load-plugins

	-- require("info_")
	-- require("unnest_")
	-- require("vim-rsi_")
	require("flatten_")

	-- require("test_")

end

-- # require later

do

	-- # redefine `require` function

	local original_require = require
	local require = function(modname) later(function() original_require(modname) end) end

	-- # library

	-- require("mini-pick_")
	require("fzf-lua_")
	require("telescope_")

	-- # main

	-- require("Comment_")
	-- require("LuaSnip_")
	-- require("NeoComposer_")
	-- require("aerial_")
	-- require("atone_")
	-- require("auto-cmdheight_")
	-- require("bufferline_")
	-- require("fcitx_") -- cursor flicker when <esc>
	-- require("fidget_")
	-- require("fzfx_")
	-- require("gitsigns_")
	-- require("harpoon_")
	-- require("indent-blankline_")
	-- require("lazygit_")
	-- require("lualine_")
	-- require("mini-bracketed_")
	-- require("mini-clue_")
	-- require("mini-notify_")
	-- require("_mini-pick__luaexec")
	-- require("_mini-pick__outliner")
	-- require("mini-statusline_")
	-- require("neo-tree_")
	-- require("nvim-better-n_")
	-- require("nvim-bqf_")
	-- require("nvim-cmp_")
	-- require("nvim-colorizer_")
	-- require("nvim-ghost_")
	-- require("nvim-next_")
	-- require("nvim-recorder_")
	-- require("nvim-spider_")
	-- require("nvim-surround_")
	-- require("nvim-ufo_")
	-- require("outline_")
	-- require("_outline_HACK2")
	-- require("quicker_")
	-- require("sidebar_")
	-- require("snacks_")
	-- require("sniprun_")
	-- require("substitute_")
	-- require("tT_")
	-- require("undotree-jiaoshijie_")
	-- require("vim-ReplaceWithRegister_")
	-- require("vim-mark_")
	-- require("vim-table-mode_")
	-- require("vuffers_")
	-- require("which-key_")
	-- require("yazi_")
	-- require("zen-mode_")
	-- require("guicursor")
	-- require("redir")
	require("auto-save_")
	require("blink-cmp_")
	require("conform_")
	require("friendly-snippets_")
	require("_fzf-lua__enchanted-files")
	require("_fzf-lua__frecency")
	require("_fzf-lua__luaexec")
	require("_fzf-lua__outliner")
	require("lfsp_")
	require("macro_")
	require("markdown-preview_")
	require("marks_")
	require("mini-ai_")
	require("mini-align_")
	require("mini-bufremove_")
	require("mini-comment_")
	require("mini-diff_")
	require("mini-hipatterns_")
	require("mini-indentscope_")
	require("mini-keymap_")
	require("mini-move_")
	require("mini-operators_")
	require("mini-snippets_")
	require("mini-splitjoin_")
	require("mini-surround_")
	require("mini-visits_")
	require("nvim-neoclip_")
	require("nvim-treesitter_") -- slow
	require("nvim-treesitter-textobjects_")
	require("operator_")
	require("paramo_")
	require("readline_")
	require("sentiment_")
	require("text-case_")
	require("toggleterm_")
	require("undotree-mbbill_")
	require("vim-AdvancedSorters_")
	require("vim-suda_")
	require("autoindent")
	require("diagnostic")

	-- require("fix-cursor_") -- too hacky and fragile
	-- require("fix-cursor_cmdatom")

	require("cmdatom")

end
