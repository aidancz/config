" may overridden, see ':h initialization'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ option
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nocompatible
" set nocompatible

" archlinux has a default vim config at '/usr/share/vim/vimfiles/archlinux.vim', this option has already been set there
" find the location via ':verbose set compatible?'
" if no user vimrc is found, this option will also be set via 'default.vim', see ':h defaults.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
" set t_Co=16
set notermguicolors

set number
set relativenumber
set guicursor=
" set cursorline
set noshowmode
" show '-- INSERT --' when switching to insert mode, etc
set wildmenu
" using wildchar (usually <tab>) to perform a command-line completion, shows a menu
set wildoptions=pum,tagfile
" pum: popup menu
set shortmess-=S shortmess+=c shortmess+=I
" show [1/5] when searching
set showcmd
" show z when using zz, etc

set list
set listchars=
" ·	middle dot		u+00b7
" ▫	white small square	u+25ab
" set listchars+=tab:\·\ ,
" set listchars+=multispace:▫,lead:▫,trail:▫,
set listchars+=tab:\ \ ,

set listchars+=eol:\ ,
set virtualedit=onemore,block
autocmd InsertLeave * :norm `^

set conceallevel=0
set concealcursor=""

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ motion
set startofline

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ timeout
" in terminal, press <a-j> or <esc>j send the same keycode '^[j' to program
" if you are vim, when you receive keycode '^[', you can choose wait or not
set notimeout
" timeout: whether '^[j and zz' timeout
set ttimeout
" ttimeout: whether '^[j' timeout, t means terminal
set timeoutlen=100
set ttimeoutlen=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search
set nohlsearch
set incsearch
set ignorecase
set smartcase
set magic

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ copy & paste
set clipboard^=unnamed,unnamedplus

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ indent
set tabstop=8
set softtabstop=0
set shiftwidth=8
" tabstop:	? column of whitespace \t		worth
" softtabstop:	? column of whitespace <tab>/<bs>	worth, 0 turns off this feature
" shiftwidth:	? column of whitespace >>/<<		worth
" we abbreviate '? column of whitespace' as 'indent' from now on
" https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

set noexpandtab
" expandtab: replace '\t' with ' '

set autoindent
" autoindent: when create a new line, copy indent from the line above
set copyindent
" copyindent: based on 'autoindent', when create a new line, copy indent (use same whitespace chars) from the line above

" let's say we have '▫▫▫·alice and bob', and press 'o' (▫ space · tab █ cursor)
" 'autoindent': '·▫▫▫█'
" 'autoindent' & 'copyindent': '▫▫▫·█'

set nosmarttab
" smarttab: at line start, use shiftwidth instead of softtabstop
set preserveindent
" preserveindent: at line start, when use >>/<<, preserve current indent

" let's say we have '▫▫▫·alice and bob'
" 'preserveindent': '▫▫▫·▫▫▫·alice and bob'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ auto linebreak
set textwidth=0
set wrapmargin=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ buffer window tab
set hidden
set scrolloff=0
set foldmethod=marker
set foldtext=getline(v:foldstart)
set fillchars=
set fillchars+=fold:\ ,
set splitbelow
set splitright
set equalalways
set nowinfixheight

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ misc
set cpoptions-=_
" [nvim only] when using 'cw', do not treat like 'ce'
" https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
set updatetime=100
" https://github.com/iamcco/markdown-preview.nvim/issues/4
set backspace=indent,eol,start,nostop

" autocmd BufEnter * set fo-=c fo-=r fo-=o
set formatoptions-=c formatoptions-=r formatoptions-=o
" disable automatic comment on newline
" not using 'set fo-=cro' because ':h add-option-flags'
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
" ':h map-table'

" nnoremap <expr> zh 'zt' . winheight(0)/4 . '<c-y>'
" nnoremap <expr> zl 'zb' . winheight(0)/4 . '<c-e>'
" https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim

nnoremap <c-g> <esc>
inoremap <c-g> <c-c>
cnoremap <c-g> <c-c>
vnoremap <c-g> <esc>

" nnoremap ; :
" vnoremap ; :

nnoremap Y y$

nnoremap <silent> <c-j> zt
nnoremap <silent> <c-k> zb
nnoremap <silent> <c-l> zz
inoremap <silent> <c-j> <c-o>zt
inoremap <silent> <c-k> <c-o>zb
inoremap <silent> <c-l> <c-o>zz
nnoremap <silent> <s-j> :put _<cr>
nnoremap <silent> <s-k> :put! _<cr>
nnoremap <silent> <a-j> :m +1<cr>
nnoremap <silent> <a-k> :m -2<cr>
" [nvim only] <a-j> etc

noremap  <silent> <f1> <esc>:silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>
noremap! <silent> <f1> <esc>:silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>
" https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

noremap  <silent> <f7> <esc>:put =strftime('%F')<cr>
noremap! <silent> <f7> <esc>:put =strftime('%F')<cr>

func! CompileRunGcc()
	exe 'w'
	if     &filetype == 'markdown'
		exe 'MarkdownPreview'
	elseif &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc % -o %< && time ./%<
	endif
endfunc
nnoremap <f5> :call CompileRunGcc()<cr>

nmap <f3> gO

let mapleader=' '

" 

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug_install
" https://github.com/junegunn/vim-plug#installation

" run ':PlugInstall' inside vim to install the plugs
" https://github.com/junegunn/vim-plug#commands



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug_config
" call plug#begin()                             "vim
call plug#begin(stdpath('data') . '/plugged') "nvim

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
" Plug 'altercation/vim-colors-solarized'
" Plug 'nordtheme/vim'
" Plug 'shaunsingh/nord.nvim'
" Plug 'mbulat/penumbra', { 'branch': 'vim', 'rtp':'vim' }
" Plug 'nekonako/xresources-nvim'
" Plug 'martineausimon/nvim-xresources'
" Plug 'robertmeta/nofrils'
Plug 'aidancz/nofrils'

" Plug 'ap/vim-css-color'
" Plug 'RRethy/vim-hexokinase'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ editor enhancement
" Plug 'jiangmiao/auto-pairs'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tommcdo/vim-lion'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'aidancz/vim-barbaric'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ file navigation
" Plug 'preservim/nerdtree'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode'
" Plug 'preservim/vim-markdown'
" Plug 'Scuilion/markdown-drawer'
" Plug 'NikitaIvanovV/vim-markdown-outline'
Plug 'aidancz/vim-markdown-outline'

call plug#end()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ script
" put these lines here because:
" open https://github.com/junegunn/vim-plug, search 'filetype'

filetype on

filetype plugin indent on
" filetype plugin indent off
" see ':h :filetype-overview'

syntax on
" syntax off

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ overrule ftplugin with filetype autocmd
" ':h ftplugin-overrule'
" https://stackoverflow.com/questions/1413285/multiple-autocommands-in-vim

function SetMarkdown()
	setlocal commentstring=#%s
endfunction
autocmd FileType markdown call SetMarkdown()

function SetVim()
	setlocal commentstring=\"%s
endfunction
autocmd FileType vim call SetVim()

function SetQf()
	" setlocal nowinfixheight
	" wincmd =

	wincmd _
	nnoremap <buffer> <silent> <cr> <cr>:only<cr>
	nnoremap <buffer> <silent> <f3> :q<cr>
	nnoremap <buffer> <silent> q    :q<cr>
endfunction
autocmd FileType qf call SetQf()

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ filename autocmd
autocmd FocusLost,QuitPre * ++nested silent! wa
" https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost

autocmd BufRead log.txt silent $

autocmd BufWritePost dirs,files silent !bookmarks

" autocmd BufRead,BufNewFile xresources* set filetype=xdefaults
" autocmd BufWritePost xresources* !xrdb % 2> /dev/null

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /usr/share/nvim/runtime/ftplugin/markdown.vim
" let g:markdown_folding = 1
" let g:markdown_recommended_style = 0



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ plug_config {{{

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nofrils
source ~/sync_git/nofrils/colors/nofrils.vim
" colorscheme nofrils

nnoremap <silent> <f9> :NofrilsToggle<cr>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-lion
let g:lion_squeeze_spaces = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ markdown-preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = 'g:Open_browser'
let g:mkdp_preview_options = {
	\ 'mkit': {'breaks': 'true'},
	\ 'katex': {},
	\ 'uml': {},
	\ 'maid': {},
	\ 'disable_sync_scroll': 0,
	\ 'sync_scroll_type': 'middle',
	\ 'hide_yaml_meta': 1,
	\ 'sequence_diagrams': {},
	\ 'flowchart_diagrams': {},
	\ 'content_editable': v:false,
	\ 'disable_filename': 1
	\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '${name}'
let g:mkdp_filetypes = ['markdown']
" ~~~
function! g:Open_browser(url)
	silent exec '!firefox --new-window ' . a:url . ' &'
endfunction

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-table-mode
nnoremap <leader>tm :TableModeToggle<cr>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-markdown-outline

" }}}



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ plug_config_comment {{{

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ solarized
" " let g:solarized_termcolors=16
" " let g:solarized_termtrans=0
" " let g:solarized_degrade=0
" " let g:solarized_bold=1
" " let g:solarized_underline=1
" " let g:solarized_italic=1
" " let g:solarized_contrast='normal'
" " let g:solarized_visibility='normal'
" set background=dark
" " always set this option to 'dark', let the terminal decide dark or light
" colorscheme solarized
" call togglebg#map('<F2>')

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nord
" colorscheme nord

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ xresources
" colorscheme xresources

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ penumbra
" runtime penumbra.vim
" " https://github.com/junegunn/vim-plug/issues/796
" " colorscheme penumbra

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ auto-pairs
" let g:AutoPairsMapCh = 0
" " let g:AutoPairsShortcutToggle     = '<M-p>'
" " let g:AutoPairsShortcutFastWrap   = '<M-e>'
" " let g:AutoPairsShortcutJump       = '<M-n>'
" " let g:AutoPairsShortcutBackInsert = '<M-b>'

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf
" nnoremap <leader>ff :Files<cr>
" nnoremap <leader>fb :Buffers<cr>
" nnoremap <leader>fh :History<cr>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ plug_config_comment }}}



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ pager {{{

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vimpager
let g:less = {}
let g:vimpager = {}
let g:less.scrolloff = 1024
" https://github.com/rkitover/vimpager/issues/212

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nvimpager
" autocmd User PageOpen,PageOpenFile
" 			\ nnoremap <silent> <nowait> g gg
" https://github.com/I60R/page?tab=readme-ov-file#nviminitlua-customizations-pager-only

" }}}
