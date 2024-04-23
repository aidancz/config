" may overridden, see ':h initialization'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ option
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nocompatible
" set nocompatible

" archlinux has a default vim config at '/usr/share/vim/vimfiles/archlinux.vim', this option has already been set there
" find the location via ':verbose set compatible?'
" if no user vimrc is found, this option will also be set via 'default.vim', see ':h defaults.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
" set t_Co=16
" syntax on

set number
set relativenumber
set guicursor=
" set cursorline
set wildmenu
" using wildchar (usually <tab>) to perform a command-line completion, shows a menu
set wildoptions=pum,tagfile
" pum: popup menu
set shortmess-=S
" show [1/5] when searching
set showcmd
" show z when using zz, etc

set list
set listchars=eol:\ ,
set virtualedit=onemore,block
au InsertLeave * :norm `^
" set listchars+=tab:\·\ ,
" ·	middle dot	u+00b7
set listchars+=tab:\ \ ,
" set listchars+=multispace:▫,lead:▫,trail:▫,
" ▫	white small square	u+25ab

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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ formatoptions
" au BufEnter * set fo-=c fo-=r fo-=o

" disable automatic comment on newline
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ buffer window tab
set hidden
set scrolloff=0
set foldmethod=marker

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ misc
set cpoptions-=_
" [nvim only] when using 'cw', do not treat like 'ce'
" https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
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

let mapleader=' '



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ftplugin
let g:markdown_recommended_style=0



" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vimpager
" let g:less = {}
" let g:vimpager = {}
" let g:less.scrolloff = 1024
" " https://github.com/rkitover/vimpager/issues/212






" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






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

Plug 'ap/vim-css-color'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ editor enhancement
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tommcdo/vim-lion'
Plug 'aidancz/vim-barbaric'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ file navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode'

call plug#end()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ plug_config

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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nofrils
" source ~/sync_git/nofrils/colors/nofrils.vim
colorscheme nofrils

" " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ auto-pairs
" let g:AutoPairsMapCh = 0
" " let g:AutoPairsShortcutToggle     = '<M-p>'
" " let g:AutoPairsShortcutFastWrap   = '<M-e>'
" " let g:AutoPairsShortcutJump       = '<M-n>'
" " let g:AutoPairsShortcutBackInsert = '<M-b>'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ coc

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf
" nnoremap <leader>ff :Files<cr>
" nnoremap <leader>fb :Buffers<cr>
" nnoremap <leader>fh :History<cr>

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

function! g:Open_browser(url)
	silent exec '!firefox --new-window ' . a:url . ' &'
endfunction

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-table-mode
nnoremap <leader>tm :TableModeToggle<cr>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ autocmd
au FocusLost,QuitPre * silent! wa
" autosave

" autocmd BufWritePost mdir,mfile !mdf
" autocmd BufRead,BufNewFile xresources* set filetype=xdefaults
" autocmd BufWritePost xresources* !xrdb % 2> /dev/null

" autocmd User PageOpen,PageOpenFile
" 			\ nnoremap <silent> <nowait> g gg
" https://github.com/I60R/page?tab=readme-ov-file#nviminitlua-customizations-pager-only



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ compile function
func! CompileRunGcc()
	exe 'w'
	if expand('%:e') == 'md'
		exe 'MarkdownPreview'
	elseif &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc % -o %< && time ./%<
	endif
endfunc
nnoremap <f5> :call CompileRunGcc()<cr>
