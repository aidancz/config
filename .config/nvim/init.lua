--  variable
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true



--  option
--  appearance
vim.opt.number = true
vim.opt.relativenumber = true
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

-- vim.opt.list = true
-- vim.opt.listchars = ''
-- vim.opt.listchars:append({tab = '  '})
-- vim.opt.listchars:append({eol = ' '})
-- some unicode symbols:
-- ·▫
-- use 'ga' to get the code point

vim.opt.display = {'lastline'}

vim.opt.conceallevel = 0
vim.opt.concealcursor = ''

vim.opt.fillchars = ''
vim.opt.fillchars:append({fold = ' '})

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
vim.opt.preserveindent = true
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

--  fold
vim.opt.foldmethod = 'marker'
vim.opt.foldtext = vim.fn.getline(vim.v.foldstart)

--  buffer window tab
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
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



--  map
-- ':h map-table'
-- ':h key-notation'

local winheight14_ctrle = vim.api.nvim_win_get_height(0) / 4 .. '<c-e>'
vim.keymap.set('n', '<c-n>', winheight14_ctrle)
local winheight14_ctrly = vim.api.nvim_win_get_height(0) / 4 .. '<c-y>'
vim.keymap.set('n', '<c-p>', winheight14_ctrly)
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
vim.keymap.set('!', '<c-f>', '<c-k>')

vim.keymap.set({'', 'i'}, '<f1>', '<cmd>silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>')
-- https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

vim.keymap.set({'', 'i'}, '<f2>', '<cmd>q!<cr>')

vim.keymap.set({'', 'i'}, '<f7>', [[<cmd>put =strftime('%F')<cr>]])



--  function
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



function set_cursor_virt_pos(lnum, virtcol)
	vim.fn.cursor(lnum, 1)
	while true do
		if vim.fn.virtcol(".") == virtcol then
			break
		else
			vim.cmd('normal l')
		end
	end
end

function paragraph_first_line()
	local line_number_current = vim.fn.line(".")
	local line_number = line_number_current

	while true do
		while true do
			if line_number == 1 or (vim.fn.getline(line_number) ~= "" and vim.fn.getline(line_number - 1) == "") then
				break
			else
				line_number = line_number - 1
			end
		end
		if line_number == 1 or line_number ~= line_number_current then
			break
		else
			line_number = line_number - 1
		end
	end

	set_cursor_virt_pos(line_number, vim.fn.virtcol("."))
end

function paragraph_last_line()
	local line_number_current = vim.fn.line(".")
	local line_number = line_number_current

	while true do
		while true do
			if line_number == vim.fn.line("$") or (vim.fn.getline(line_number) ~= "" and vim.fn.getline(line_number + 1) == "") then
				break
			else
				line_number = line_number + 1
			end
		end
		if line_number == vim.fn.line("$") or line_number ~= line_number_current then
			break
		else
			line_number = line_number + 1
		end
	end

	set_cursor_virt_pos(line_number, vim.fn.virtcol("."))
end

vim.keymap.set({'n', 'v'}, '(', paragraph_first_line)
vim.keymap.set('o', '(', 'V(')
vim.keymap.set({'n', 'v'}, ')', paragraph_last_line)
vim.keymap.set('o', ')', 'V)')



function time()
	vim.api.nvim_out_write(vim.fn.system({'date', '--iso-8601=ns'}))
end



--  autocmd
-- https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup

--  change option
local change_option = vim.api.nvim_create_augroup('change_option', {clear = true})

-- vim.api.nvim_create_autocmd(
-- 	{''}, {
-- 	group = change_option,
-- 	pattern = {'*'},
-- 	callback = function()
-- 		time()
-- 		print(vim.opt.modifiable:get())
-- 		if vim.opt.modifiable:get() then
-- 			return
-- 		end
-- 		vim.opt_local.number = false
-- 		vim.opt_local.relativenumber = false
-- 	end,
-- 	})

--  fix cursor position when changing mode
local cursor_position = vim.api.nvim_create_augroup('cursor_position', {clear = true})

vim.api.nvim_create_autocmd('InsertLeave', {
	group = cursor_position,
	pattern = {'*'},
	command = 'normal `^',
	})

vim.api.nvim_create_autocmd('ModeChanged', {
	group = cursor_position,
	pattern = {'*:[vV\x16]*'},
	command = 'normal mv',
	})

vim.api.nvim_create_autocmd('ModeChanged', {
	group = cursor_position,
	pattern = {'[vV\x16]*:*'},
	command = 'silent! normal `v',
	})
-- use 'silent!' to ignore the error message when press 'Vd'

--  current line eol mark
local eol_mark = vim.api.nvim_create_augroup('eol_mark', {clear = true})

local eol_mark_ns_id = vim.api.nvim_create_namespace('eol_mark')

function eol_mark_clear_and_set()
	vim.api.nvim_buf_clear_namespace(0, eol_mark_ns_id, 0, -1)
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	-- local col = #vim.api.nvim_get_current_line()
	local opts = {
		virt_text = {{'○', 'Comment'}},
		virt_text_pos = 'overlay',
		}
	vim.api.nvim_buf_set_extmark(0, eol_mark_ns_id, line, -1, opts)
end

vim.api.nvim_create_autocmd(
	{'BufWinEnter', 'CursorMoved', 'CursorMovedI'}, {
	group = eol_mark,
	pattern = {'*'},
	-- callback = time
	callback = eol_mark_clear_and_set,
	})

--  auto save
-- local timer = vim.uv.new_timer()
-- timer:start(0, 100, vim.schedule_wrap(function()
-- 	vim.cmd('echo mode(1)')
-- 	end))

local auto_save = vim.api.nvim_create_augroup('auto_save', {clear = true})

vim.api.nvim_create_autocmd(
	{'TextChanged', 'InsertLeave'}, {
	group = auto_save,
	pattern = {'*'},
	command = 'silent! wa',
	})

vim.api.nvim_create_autocmd(
	{'FocusLost', 'QuitPre'}, {
	group = auto_save,
	pattern = {'*'},
	nested = true,
	command = 'silent! wa',
	})
-- https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost

--  filetype
local filetype = vim.api.nvim_create_augroup('filetype', {clear = true})

vim.api.nvim_create_autocmd(
	'FileType', {
	group = filetype,
	pattern = {'markdown'},
	callback = function()
		vim.opt.commentstring = '●%s'
	end,
	})

vim.api.nvim_create_autocmd(
	'FileType', {
	group = filetype,
	pattern = {'c'},
	callback = function()
		vim.opt.commentstring = '//%s'
	end,
	})

vim.api.nvim_create_autocmd(
	'FileType', {
	group = filetype,
	pattern = {'vim'},
	callback = function()
		vim.opt.commentstring = '"%s'
	end,
	})

vim.api.nvim_create_autocmd(
	'FileType', {
	group = filetype,
	pattern = {'lua'},
	callback = function()
		vim.opt.commentstring = '--%s'
	end,
	})

--  filename
local filename = vim.api.nvim_create_augroup('filename', {clear = true})

vim.api.nvim_create_autocmd(
	'BufRead', {
	group = filename,
	pattern = {'log.txt'},
	command = 'silent $',
	})

vim.api.nvim_create_autocmd(
	'BufWritePost', {
	group = filename,
	pattern = {'dirs', 'files'},
	command = 'silent !bookmarks',
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
	-- 	opts = {},
	-- },
	-- {
	-- 	'lewis6991/gitsigns.nvim',
	-- 	opts = {},
	-- },
	{
		'kylechui/nvim-surround',
		opts = {},
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			toggler = {
				block = 'gbb',
			},
		},
	},
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require('mini.ai').setup()
			require('mini.align').setup()
			require('mini.operators').setup()
		end,
	},
	{
		'h-hg/fcitx.nvim',
	},
	{
		'dhruvasagar/vim-table-mode',
		config = function()
			vim.keymap.set('n', '<leader>tm', '<cmd>TableModeToggle<cr>')
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
			'nvim-tree/nvim-web-devicons',
		},
		opts = {
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
		},
		config = function(_, opts)
			require('aerial').setup(opts)
			vim.keymap.set("n", "<f3>", "<cmd>AerialToggle<CR>")
		end,
	},
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
							['<c-u>'] = false
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
			vim.keymap.set('n', '<leader>s', ':Telescope ')
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
			ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
			auto_install = true,
			highlight = {
				enable = true,
			},
			-- indent = {
			-- 	enable = true,
			-- },
		},
		config = function(_, opts)
			require('nvim-treesitter.install').prefer_git = true
			require('nvim-treesitter.configs').setup(opts)
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
