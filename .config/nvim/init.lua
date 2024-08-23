vim.loader.enable()

--  debug
-- if true then return end



--  variable
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true



--  option
--  appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = 'yes'
-- vim.opt.signcolumn = 'yes:2'
vim.opt.guicursor = ''
-- vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.wildoptions = {'pum', 'tagfile'}
vim.opt.shortmess:remove('S')
vim.opt.shortmess:append('I')
vim.opt.showmode = false
vim.opt.showcmd = false
-- wildmenu	using wildchar (usually <tab>) to perform a command-line completion, shows a menu
-- wildoptions	pum: popup menu
-- shortmess	set message form
-- showmode	show '-- INSERT --' when switching to insert mode, etc
-- showcmd	show z when using zz, etc, show size of selection when in visual mode

vim.opt.list = true
vim.opt.listchars = ''
vim.opt.listchars:append({tab = '░░'})
-- vim.opt.listchars:append({eol = '$'})
-- some unicode symbols:
-- ·▫░▒▓█
-- use 'ga' to get the code point

vim.opt.display = {'lastline'}

vim.opt.conceallevel = 0
vim.opt.concealcursor = ''

vim.opt.fillchars = ''
vim.opt.fillchars:append({eob = ' '})
vim.opt.fillchars:append({fold = ' '})
vim.opt.fillchars:append({foldclose = '●'})
vim.opt.fillchars:append({foldopen = '○'})
vim.opt.fillchars:append({foldsep = '1'})

--  navigation
vim.opt.virtualedit = {'all'}
vim.opt.startofline = false
vim.opt.jumpoptions = {'stack'}
vim.opt.scrolloff = 0
vim.opt.whichwrap:append('[,]')
vim.opt.iskeyword:remove('_')
vim.opt.smoothscroll = true

--  keypress timeout
vim.opt.timeout = false
vim.opt.timeoutlen = 8
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0
-- in terminal, press <a-j> or <esc>j send the same keycode '^[j' to program
-- if you are vim, when you receive keycode '^[', you can choose wait or not
-- timeout	whether '^[j and zz' timeout
-- ttimeout	whether '^[j' timeout, t means terminal

--  search & substitute
vim.opt.hlsearch = false
vim.opt.incsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true

vim.opt.inccommand = ''

--  copy & paste
vim.opt.clipboard:prepend({'unnamed'})
vim.opt.clipboard:prepend({'unnamedplus'})

--  indent
vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 8
-- tabstop	? column of whitespace \t worth
-- softtabstop	? column of whitespace <tab>/<bs> worth, 0 turns off this feature
-- shiftwidth	? column of whitespace >>/<< worth
-- we abbreviate '? column of whitespace' as 'indent' from now on
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

vim.opt.expandtab = false
-- expandtab	replace '\t' with ' '

vim.opt.autoindent = true
vim.opt.copyindent = true
-- autoindent	when create a new line, copy indent from the line above
-- copyindent	based on 'autoindent', when create a new line, copy indent (use same whitespace chars) from the line above
-- let's say we have '▫▫▫·alice and bob', and press 'o' (▫ space · tab █ cursor)
-- 'autoindent': '·▫▫▫█'
-- 'autoindent' & 'copyindent': '▫▫▫·█'

vim.opt.smarttab = false
vim.opt.preserveindent = false
vim.opt.shiftround = true
-- smarttab		at line start, when use <tab>, use shiftwidth instead of softtabstop
-- preserveindent	at line start, when use >>/<<, preserve current indent
-- let's say we have '▫▫▫·alice and bob', and press '>>'
-- 'preserveindent': '▫▫▫··alice and bob'

--  match pair
vim.opt.matchpairs:append('<:>')
vim.opt.showmatch = true
vim.opt.matchtime = 1

--  auto linebreak
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

vim.opt.formatoptions = ''
-- https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

--  undo
vim.opt.undofile = true

--  fold
vim.opt.foldenable = true
vim.opt.foldcolumn = '1'
vim.opt.foldtext = vim.fn.getline(vim.v.foldstart)
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0
vim.opt.foldmethod = 'marker'

--  buffer window tab
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.splitkeep = 'topline'
vim.opt.equalalways = true
vim.opt.winfixheight = false
vim.opt.cmdwinheight = 8
vim.opt.laststatus = 2
-- https://github.com/neovim/neovim/issues/18965

--  misc
vim.opt.cpoptions:remove('_')
-- vim.opt.cpoptions:append('v')
-- vim.opt.cpoptions:append('$')
-- https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing

vim.opt.updatetime = 100
-- https://github.com/iamcco/markdown-preview.nvim/issues/4

vim.opt.backspace = {'indent', 'eol', 'start', 'nostop'}

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.completeopt = {'menu', 'preview'}

vim.opt.commentstring = '#%s'



--  map
-- ':h map-table'
-- ':h key-notation'

vim.keymap.set('', '<space>', '<nop>')

vim.keymap.set('o', '{', function() return 'V' .. vim.v.count1 .. '{' end, {silent = true, expr = true})
vim.keymap.set('o', '}', function() return 'V' .. vim.v.count1 .. '}' end, {silent = true, expr = true})

vim.keymap.set('n', '<c-n>', function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. '<c-e>' end, {silent = true, expr = true})
vim.keymap.set('n', '<c-p>', function() return math.ceil(vim.api.nvim_win_get_height(0)/4) .. '<c-y>' end, {silent = true, expr = true})
-- https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim

vim.keymap.set('n', '<a-j>', ':.m .+1<cr>', {silent = true})
vim.keymap.set('n', '<a-k>', ':.m .-2<cr>', {silent = true})

vim.keymap.set('n', '<a-n>', 'nzz')
vim.keymap.set('n', '<a-p>', 'Nzz')

vim.keymap.set('n', '<down>', ':put  _<cr>', {silent = true})
vim.keymap.set('n', '<up>',   ':put! _<cr>', {silent = true})
vim.keymap.set('n', '<left>',  [["=' '<cr>P]], {silent = true})
vim.keymap.set('n', '<right>', [["=' '<cr>p]], {silent = true})

vim.keymap.set('n', '<f3>', 'gO', {remap = true})



vim.keymap.set('i', '<down>', '<c-n>')
vim.keymap.set('i', '<up>',   '<c-p>')



vim.keymap.set({'n', 'x'}, 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
	end, {expr = true})
vim.keymap.set({'n', 'x'}, 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
	end, {expr = true})

vim.keymap.set({'', 'i'}, '<c-s>', '<cmd>normal zz<cr>')
vim.keymap.set({'', 'i'}, '<c-j>', '<cmd>normal zt<cr>')
vim.keymap.set({'', 'i'}, '<c-k>', '<cmd>normal zb<cr>')
vim.keymap.set({'', 'i'}, '<c-h>', '<cmd>normal zz<c-n><cr>', {remap = true})
vim.keymap.set({'', 'i'}, '<c-l>', '<cmd>normal zz<c-p><cr>', {remap = true})
vim.keymap.set('!', '<a-v>', '<c-k>')

vim.keymap.set({'', 'i'}, '<f1>', '<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>')
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

vim.keymap.set({'', 'i'}, '<f2>', '<cmd>q!<cr>')

vim.keymap.set({'', 'i'}, '<f7>', [[<cmd>put =strftime('%F')<cr>]])



vim.api.nvim_create_user_command('Date', [[put =strftime('%F')]], {})

vim.api.nvim_create_user_command('TrailRemove', [[%s/\s\+$//e]], {})
-- https://vim.fandom.com/wiki/Remove_unwanted_spaces

vim.api.nvim_create_user_command('SearchMiddleToggle',
	function()
		if vim.fn.mapcheck('n') == '' then
			vim.keymap.set('n', 'n', 'nzz')
			vim.keymap.set('n', 'N', 'Nzz')
		else
			vim.keymap.del('n', 'n')
			vim.keymap.del('n', 'N')
		end
	end,
	{})



--  function
--  compile
function compile()
	vim.cmd('w')

	local filetype = vim.bo.filetype
	if filetype == 'markdown' then
		vim.cmd('MarkdownPreview')
	end
	if filetype == 'c' then
		vim.cmd([[silent! !gcc % -o %<]])
		vim.cmd([[silent! !setsid -f $TERMINAL -e bash -c "%:p:r; bash"]])
	end
end
vim.keymap.set('n', '<f5>', compile)

--  paragraph_textline (para_textl)
local function para_textl_head_p(lnum)
	if lnum == 1 then
		return true
	end
	if vim.fn.getline(lnum) ~= '' and vim.fn.getline(lnum - 1) == '' then
		return true
	end
	return false
end

local function para_textl_tail_p(lnum)
	if lnum == vim.fn.line('$') then
		return true
	end
	if vim.fn.getline(lnum) ~= '' and vim.fn.getline(lnum + 1) == '' then
		return true
	end
	return false
end

local function para_textl_backward_lnum(lnum)
	if lnum == 1 then
		return lnum
	end
	if para_textl_head_p(lnum - 1) then
		return lnum - 1
	end
	return para_textl_backward_lnum(lnum - 1)
end

local function para_textl_forward_lnum(lnum)
	if lnum == vim.fn.line('$') then
		return lnum
	end
	if para_textl_tail_p(lnum + 1) then
		return lnum + 1
	end
	return para_textl_forward_lnum(lnum + 1)
end

rep_call = function(func, arg, count)
	if count == 0 then
		return func(arg)
	else
		return rep_call(func, func(arg), (count - 1))
	end
end

local function para_textl_backward()
	local lnum_current = vim.fn.line('.')
	local lnum_destination = rep_call(para_textl_backward_lnum, lnum_current, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

local function para_textl_forward()
	local lnum_current = vim.fn.line('.')
	local lnum_destination = rep_call(para_textl_forward_lnum, lnum_current, (vim.v.count1 - 1))
	vim.cmd(tostring(lnum_destination))
end

vim.keymap.set({'n', 'v'}, '(', para_textl_backward)
vim.keymap.set('o', '(', function() return ':normal V' .. vim.v.count1 .. '(<cr>' end, {silent = true, expr = true})
vim.keymap.set({'n', 'v'}, ')', para_textl_forward)
vim.keymap.set('o', ')', function() return ':normal V' .. vim.v.count1 .. ')<cr>' end, {silent = true, expr = true})
-- https://vi.stackexchange.com/questions/6101/is-there-a-text-object-for-current-line/6102#6102

--  misc
function time()
	vim.api.nvim_out_write(vim.fn.system({'date', '--iso-8601=ns'}))
end



--  autocmd
-- https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup

--  change option
local change_option_augroup = vim.api.nvim_create_augroup('change_option', {clear = true})

-- vim.api.nvim_create_autocmd(
-- 	{},
-- 	{
-- 		group = change_option_augroup,
-- 		pattern = {'*'},
-- 		callback = function()
-- 			time()
-- 			print(vim.opt.modifiable:get())
-- 			if vim.opt.modifiable:get() then
-- 				return
-- 			end
-- 			vim.opt_local.number = false
-- 			vim.opt_local.relativenumber = false
-- 		end,
-- 	})

--  fix cursor position when changing mode
local cursor_position_augroup = vim.api.nvim_create_augroup('cursor_position', {clear = true})

vim.api.nvim_create_autocmd(
	'InsertLeave',
	{
		group = cursor_position_augroup,
		pattern = {'*'},
		command = 'normal `^',
	})

-- vim.api.nvim_create_autocmd(
-- 	'ModeChanged',
-- 	{
-- 		group = cursor_position_augroup,
-- 		pattern = {'n:*'},
-- 		command = 'normal mn',
-- 	})
-- -- may conflict with plugin! (vim-mark)

-- vim.api.nvim_create_autocmd(
-- 	'ModeChanged',
-- 	{
-- 		group = cursor_position_augroup,
-- 		pattern = {'[vV\x16]*:n'},
-- 		command = 'silent! normal `n',
-- 	})
-- -- use 'silent!' to ignore the error message when press 'Vd'
-- -- may conflict with plugin! (mini.ai)

--  eol extmark at cursor line
-- https://github.com/echasnovski/mini.nvim/issues/990

local eol_extmark_ns_id = vim.api.nvim_create_namespace('eol_extmark')

vim.api.nvim_set_hl(0, 'EolExtmark', {link = 'Comment'})

local eol_extmark_opts = {
	virt_text = {{'○', 'EolExtmark'}},
	virt_text_pos = 'overlay',
}

local eol_extmark_id

local show_eol_at_cursor_line = function(args)
	if vim.api.nvim_get_current_buf() ~= args.buf then return end
	eol_extmark_opts.id = eol_extmark_id
	local line = vim.fn.line('.') - 1
	eol_extmark_id = vim.api.nvim_buf_set_extmark(args.buf, eol_extmark_ns_id, line, -1, eol_extmark_opts)
end



local eol_extmark_augroup = vim.api.nvim_create_augroup('eol_extmark', {clear = true})

vim.api.nvim_create_autocmd(
	{'BufEnter', 'CursorMoved', 'CursorMovedI'},
	{
		group = eol_extmark_augroup,
		callback = show_eol_at_cursor_line,
	})

--  auto save
-- local timer = vim.uv.new_timer()
-- timer:start(0, 100, vim.schedule_wrap(function()
-- 	vim.cmd('echo mode(1)')
-- 	end))

local auto_save_augroup = vim.api.nvim_create_augroup('auto_save', {clear = true})

vim.api.nvim_create_autocmd(
	{'TextChanged', 'InsertLeave'},
	{
		group = auto_save_augroup,
		pattern = {'*'},
		command = 'silent! wa',
	})

vim.api.nvim_create_autocmd(
	{'FocusLost', 'QuitPre'},
	{
		group = auto_save_augroup,
		pattern = {'*'},
		nested = true,
		command = 'silent! wa',
	})
-- https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost

--  filetype
local filetype_augroup = vim.api.nvim_create_augroup('filetype', {clear = true})

vim.api.nvim_create_autocmd(
	'FileType',
	{
		group = filetype_augroup,
		pattern = {'markdown'},
		callback = function()
			vim.opt.commentstring = '●%s'
		end,
	})

vim.api.nvim_create_autocmd(
	'FileType',
	{
		group = filetype_augroup,
		pattern = {'c'},
		callback = function()
			vim.opt.commentstring = '//%s'
		end,
	})

vim.api.nvim_create_autocmd(
	'FileType',
	{
		group = filetype_augroup,
		pattern = {'vim'},
		callback = function()
			vim.opt.commentstring = '"%s'
		end,
	})

vim.api.nvim_create_autocmd(
	'FileType',
	{
		group = filetype_augroup,
		pattern = {'lua'},
		callback = function()
			vim.opt.commentstring = '--%s'
		end,
	})

vim.api.nvim_create_autocmd(
	'FileType',
	{
		group = filetype_augroup,
		pattern = {'man'},
		callback = function()
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.signcolumn = 'no'
		end,
	})

--  filename
local filename_augroup = vim.api.nvim_create_augroup('filename', {clear = true})

vim.api.nvim_create_autocmd(
	'BufRead',
	{
		group = filename_augroup,
		pattern = {'log.txt'},
		command = 'silent $',
	})



--  builtin plugin
vim.cmd([[
filetype on
filetype plugin off
filetype indent off
syntax off
]])

vim.fn.digraph_set('oo', '●')
vim.fn.digraph_set('xx', '×')
vim.fn.digraph_set('-<', '←')
vim.fn.digraph_set('-^', '↑')
vim.fn.digraph_set('^v', '↕')



--  plugin
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
{

	{
		'aidancz/nofrils',
		dev = true,
		config = function()
			vim.cmd('colorscheme nofrils')
		end,
	},
	-- {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	main = 'ibl',
	-- 	config = function()
	-- 		require('ibl').setup({
	-- 			indent = {char = '┃'},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	'lewis6991/gitsigns.nvim',
	-- 	config = function()
	-- 		require('gitsigns').setup({})
	-- 	end,
	-- },
	{
		'utilyre/sentiment.nvim',
		init = function()
			vim.g.loaded_matchparen = 1
			vim.opt.showmatch = false
		end,
		config = function()
			require('sentiment').setup({
				included_modes = {
					n = true,
					i = true,
				},
				delay = 0,
			})
		end,
	},
	-- {
	-- 	'kevinhwang91/nvim-ufo',
	-- 	dependencies = {
	-- 		'kevinhwang91/promise-async',
	-- 	},
	-- 	config = function()
	-- 		require('ufo').setup({
	-- 			provider_selector = function(bufnr, filetype, buftype)
	-- 				return ''
	-- 			end,
	-- 			fold_virt_text_handler = function() return vim.fn.getline(vim.v.foldstart) end,
	-- 		})
	-- 	end,
	-- },
	{
		'inkarkat/vim-mark',
		dependencies = {
			'inkarkat/vim-ingo-library',
		},
		config = function()
			vim.api.nvim_set_hl(0, 'MarkWord1', {link = 'nofrils-red-bg'})
			vim.api.nvim_set_hl(0, 'MarkWord2', {link = 'nofrils-green-bg'})
			vim.api.nvim_set_hl(0, 'MarkWord3', {link = 'nofrils-yellow-bg'})
			vim.api.nvim_set_hl(0, 'MarkWord4', {link = 'nofrils-blue-bg'})
			vim.api.nvim_set_hl(0, 'MarkWord5', {link = 'nofrils-magenta-bg'})
			vim.api.nvim_set_hl(0, 'MarkWord6', {link = 'nofrils-cyan-bg'})
		end,
	},
	{
		'chentoast/marks.nvim',
		config = function()
			require('marks').setup({
				default_mappings = true,
				builtin_marks = {".", "<", ">", "^"},
				cyclic = true,
				force_write_shada = false,
				refresh_interval = 150,
				sign_priority = {lower=10, upper=15, builtin=8, bookmark=20},
				excluded_filetypes = {},
				excluded_buftypes = {},
				bookmark_0 = {
					sign = "⚑",
					virt_text = "",
					annotate = false,
				},
				mappings = {}
			})
		end,
	},
	{
		'kylechui/nvim-surround',
		config = function()
			require('nvim-surround').setup({})
		end,
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup({
				toggler = {
					block = 'gbb',
				},
			})
		end,
	},
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require('mini.ai').setup({
				custom_textobjects = {
					g = function()
						local from = { line = 1, col = 1 }
						local to = {
							line = vim.fn.line('$'),
							col = math.max(vim.fn.getline('$'):len(), 1)
						}
						return { from = from, to = to, vis_mode = 'V' }
					end,
				},
			})
			require('mini.align').setup({})
			require('mini.operators').setup({})
			require('mini.trailspace').setup({})
			vim.api.nvim_set_hl(0, 'MiniTrailspace', {link = 'nofrils-yellow-bg'})
		end,
	},
	{
		'mbbill/undotree',
	},
	{
		'h-hg/fcitx.nvim',
	},
	{
		'dhruvasagar/vim-table-mode',
		config = function()
			vim.g.table_mode_corner = '|'
		end,
	},
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function() vim.fn['mkdp#util#install']() end,
		config = function()

			vim.g.mkdp_auto_start = false
			vim.g.mkdp_auto_close = true
			vim.g.mkdp_refresh_slow = false
			vim.g.mkdp_command_for_global = false
			vim.g.mkdp_open_to_the_world = false
			vim.g.mkdp_open_ip = ''
			vim.g.mkdp_browser = ''
			vim.g.mkdp_echo_preview_url = false

			-- function open_browser(url)
			-- 	vim.cmd('silent !firefox --new-window' .. ' ' .. url)
			-- end

			vim.cmd([[
			function OpenBrowser(url)
				silent execute '!firefox --new-window' . ' ' . a:url
			endfunction
			]])

			vim.g.mkdp_browserfunc = 'OpenBrowser'
			vim.g.mkdp_preview_options = {
				mkit = {breaks = true},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = false,
				sync_scroll_type = 'middle',
				hide_yaml_meta = true,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				content_editable = false,
				disable_filename = true,
			}
			vim.g.mkdp_markdown_css = ''
			vim.g.mkdp_highlight_css = ''
			vim.g.mkdp_port = ''
			vim.g.mkdp_page_title = '${name}'
			vim.g.mkdp_filetypes = {'markdown'}

		end,
	},
	{
		'stevearc/aerial.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			-- 'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('aerial').setup({
				keymaps = {
					['?']      = false,
					['<C-j>']  = false,
					['<C-k>']  = false,
					['<C-s>']  = false,
					['<C-v>']  = false,
					['<a-j>']  = 'actions.down_and_scroll',
					['<a-k>']  = 'actions.up_and_scroll',
					['<a-s>']  = 'actions.jump_split',
					['<a-v>']  = 'actions.jump_vsplit',
				},
				layout = {
					width = 0.5,
					max_width = 0.5,
					min_width = 0.5,
					default_direction = 'float',
					resize_to_content = false,
				},
				float = {
					height = 0.8,
					max_height = 0.8,
					min_height = 0.8,
					border = 'single',
					relative = 'editor',
				},
			})

			vim.keymap.set('n', '<f3>', '<cmd>AerialToggle<cr>')
		end,
	},
	-- {
	-- 	'hedyhli/outline.nvim',
	-- 	config = function()
	-- 		require('outline').setup({})
	-- 	end,
	-- },
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			{
				'nvim-lua/plenary.nvim',
			},
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{
				'nvim-telescope/telescope-ui-select.nvim'
			},
		},
		config = function()
			require('telescope').setup({
				defaults = {
					layout_config = {
						horizontal = {
							preview_cutoff = 0,
							preview_width = 0.5
						},
					},
					mappings = {
						i = {
							['<esc>'] = 'close',
							['<c-u>'] = false,
						},
					},
				},
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			})
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('ui-select')
		end,
	},
	{
		'ibhagwan/fzf-lua',
		config = function()
			require("fzf-lua").setup({
				keymap = {
					builtin = {
					},
					fzf = {
						['f2'] = 'abort',
					},
				},
			})
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.install').prefer_git = true
			require('nvim-treesitter.configs').setup({
				ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				-- indent = {
				-- 	enable = true,
				-- },
			})
			-- vim.api.nvim_set_hl(0, '@comment', {link = 'Comment'})
		end,
	},
	-- {
	-- 	'neovim/nvim-lspconfig',
	-- 	dependencies = {
	-- 		-- {'williamboman/mason.nvim'},
	-- 		-- {'williamboman/mason-lspconfig.nvim'},
	--
	-- 		{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	-- 	},
	-- 	config = function()
	-- 		local lsp_zero = require('lsp-zero')
	-- 		lsp_zero.on_attach(function(client, bufnr)
	-- 				lsp_zero.default_keymaps({buffer = bufnr})
	-- 				end)
	--
	-- 		require('lspconfig').lua_ls.setup({})
	-- 	end,
	-- },
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-cmdline'},
			{'hrsh7th/cmp-nvim-lsp'},
		},
		config = function()
			local cmp = require('cmp')

			cmp.setup({
				completion = {
					completeopt = 'menu,menuone,noselect',
				},
				window = {
					completion    = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources(
					{
						{name = 'path'},
					},
					{
						{name = 'cmdline'},
					}),
			})
			-- cmp.setup.cmdline({'/', '?'}, {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{name = 'buffer'},
			-- 	}
			-- })
		end,
	},
	-- {
	-- 	'L3MON4D3/LuaSnip',
	-- },
	{
		'mikavilpas/yazi.nvim',
		config = function()
			require('yazi').setup({})
			vim.api.nvim_create_user_command('Yazi', function() require('yazi').yazi() end, {})
		end,
	},

},
{

	dev = {
		path = '~/sync_git',
	},
	lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',

}
)
