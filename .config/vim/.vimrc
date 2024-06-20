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
" set signcolumn=yes:2
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
set noshowcmd
" show z when using zz, etc, show size of selection when in visual mode

set list
set listchars=
" ·	middle dot		u+00b7
" ▫	white small square	u+25ab
" set listchars+=tab:\·\ ,
" set listchars+=multispace:▫,lead:▫,trail:▫,
set listchars+=tab:\ \ ,

set listchars+=eol:\ ,
" set virtualedit=onemore,block
set virtualedit=all
autocmd InsertLeave * :normal `^
autocmd ModeChanged *:[vV\x16]* :normal mv
autocmd Modechanged [vV\x16]*:* :normal `v

set conceallevel=0
set concealcursor=""

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ navigation
set nostartofline
set jumpoptions=stack

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ timeout
" in terminal, press <a-j> or <esc>j send the same keycode '^[j' to program
" if you are vim, when you receive keycode '^[', you can choose wait or not
set notimeout
" timeout: whether '^[j and zz' timeout
set ttimeout
" ttimeout: whether '^[j' timeout, t means terminal
" set timeoutlen=0
set ttimeoutlen=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search & substitute
set nohlsearch
set noincsearch
set ignorecase
set smartcase
set magic

set inccommand=

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ copy & paste
set clipboard^=unnamed,unnamedplus

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ indent
" [ftplugin]

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

" autocmd BufEnter * set fo-=c fo-=r fo-=o
" set formatoptions-=c formatoptions-=r formatoptions-=o
set formatoptions=
" [ftplugin]
" disable automatic comment on newline
" not using 'set fo-=cro' because ':h add-option-flags'
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

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
set cmdwinheight=8

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ auto save
autocmd FocusLost,QuitPre * ++nested silent! wa
" https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ misc
set cpoptions-=_
" [nvim only] when using 'cw', do not treat like 'ce'
" https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
" set cpoptions+=v
" set cpoptions+=$

set updatetime=100
" https://github.com/iamcco/markdown-preview.nvim/issues/4

set backspace=indent,eol,start,nostop
set whichwrap+=[,]

set showmatch
set matchtime=1

set iskeyword-=_

set matchpairs+=<:>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
" ':h map-table'
" ':h key-notation'

" nnoremap ; :
" vnoremap ; :

" nnoremap <c-g> <esc>
" inoremap <c-g> <c-c>
" cnoremap <c-g> <c-c>
" vnoremap <c-g> <esc>

" nnoremap <expr> zh 'zt' . winheight(0)/4 . '<c-y>'
" nnoremap <expr> zl 'zb' . winheight(0)/4 . '<c-e>'
" https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim

nnoremap Y y$

nnoremap <expr> <c-n> winheight(0)/4 . '<c-e>'
nnoremap <expr> <c-p> winheight(0)/4 . '<c-y>'

nnoremap <silent> <c-s> zz
nnoremap <silent> <c-j> zt
nnoremap <silent> <c-k> zb
nmap     <silent> <c-l> zz<c-n>
nmap     <silent> <c-h> zz<c-p>
" ---
inoremap <silent> <c-s> <c-o>zz
inoremap <silent> <c-j> <c-o>zt
inoremap <silent> <c-k> <c-o>zb
imap     <silent> <c-l> <c-o>zz<c-o><c-n>
imap     <silent> <c-h> <c-o>zz<c-o><c-p>
" ---
noremap! <c-f> <c-k>
inoremap <silent> <down>  <c-n>
inoremap <silent> <up>    <c-p>

nnoremap <silent> <down>  :put  _<cr>
nnoremap <silent> <up>    :put! _<cr>
nnoremap <silent> <left>  "=' '<cr>P
nnoremap <silent> <right> "=' '<cr>p
nnoremap <silent> <pagedown> nzz
nnoremap <silent> <pageup> Nzz
" https://github.com/tpope/vim-unimpaired

nnoremap <silent> <s-j> :m +1<cr>
nnoremap <silent> <s-k> :m -2<cr>
" [nvim only] <a-j> <a-k> etc



noremap  <silent> <f1> <esc>:silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>
noremap! <silent> <f1> <esc>:silent! !setsid -f $TERMINAL >/dev/null 2>&1<cr>
" https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently

noremap  <silent> <f2> <esc>:q!<cr>
noremap! <silent> <f2> <esc>:q!<cr>

nmap <f3> gO

noremap  <silent> <f7> <esc>:put =strftime('%F')<cr>
noremap! <silent> <f7> <esc>:put =strftime('%F')<cr>

let mapleader=' '



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ script
function! Compile()
	execute 'w'

	if	&filetype == 'markdown'
		execute 'MarkdownPreview'

	elseif	&filetype == 'c'
		silent! !gcc % -o %<
		silent! !setsid -f $TERMINAL -e bash -c "%:p:r; bash"
	endif
endfunc
nnoremap <f5> :call Compile()<cr>



xnoremap il g_o0
onoremap il :normal vil<cr>
xnoremap al $o0
onoremap al :normal val<cr>
xnoremap i% GoggV
onoremap i% :normal vi%<cr>
" https://vi.stackexchange.com/questions/6101/is-there-a-text-object-for-current-line/6102#6102



function! SetCursorVirtPos(lnum, virtcol)
	call cursor(a:lnum, 1)
	while 1
		if virtcol(".") == a:virtcol
			break
		else
			normal l
		endif
	endwhile
endfunction

function! ParagraphFirstLine()
	let line_number_current = line(".")
	let line_number = line_number_current
	while 1
		while 1
			if line_number == 1 || ( getline(line_number) != "" && getline(line_number - 1) == "" )
				break
			else
				let line_number -= 1
			endif
		endwhile
		if line_number == 1 || line_number != line_number_current
			break
		else
			let line_number -= 1
		endif
	endwhile
	call SetCursorVirtPos(line_number, virtcol("."))
endfunction

function! ParagraphLastLine()
	let line_number_current = line(".")
	let line_number = line_number_current
	while 1
		while 1
			if line_number == line("$") || ( getline(line_number) != "" && getline(line_number + 1) == "" )
				break
			else
				let line_number += 1
			endif
		endwhile
		if line_number == line("$") || line_number != line_number_current
			break
		else
			let line_number += 1
		endif
	endwhile
	call SetCursorVirtPos(line_number, virtcol("."))
endfunction

function! VisMove(f)
    normal! gv
    call function(a:f)()
endfunction
" https://stackoverflow.com/questions/16212801/how-to-call-a-function-that-moves-the-cursor-without-leaving-visual-mode

nnoremap <silent> ( :call ParagraphFirstLine()<cr>
xnoremap <silent> ( :<c-u>call VisMove('ParagraphFirstLine')<cr>
onoremap ( :normal V(<cr>
nnoremap <silent> ) :call ParagraphLastLine()<cr>
xnoremap <silent> ) :<c-u>call VisMove('ParagraphLastLine')<cr>
onoremap ) :normal V)<cr>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug
" https://github.com/junegunn/vim-plug#installation

" run ':PlugInstall' inside vim to install the plugs
" https://github.com/junegunn/vim-plug#commands



" call plug#begin()                             " vim
call plug#begin(stdpath('data') . '/plugged') " nvim

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
" Plug 'altercation/vim-colors-solarized'
" Plug 'nordtheme/vim'
" Plug 'shaunsingh/nord.nvim'
" Plug 'mbulat/penumbra', { 'branch': 'vim', 'rtp':'vim' }
" Plug 'nekonako/xresources-nvim'
" Plug 'martineausimon/nvim-xresources'
" Plug 'robertmeta/nofrils'
" Plug 'aidancz/nofrils'
Plug '~/sync_git/nofrils'

" Plug 'ap/vim-css-color'
" Plug 'RRethy/vim-hexokinase'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ editor enhancement
" Plug 'jiangmiao/auto-pairs'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-rsi'
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
" Plug 'aidancz/vim-markdown-outline'
Plug '~/sync_git/vim-markdown-outline'

call plug#end()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ plug_config

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nofrils
colorscheme nofrils

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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vimpager
let g:less = {}
let g:vimpager = {}
let g:less.scrolloff = 1024
" https://github.com/rkitover/vimpager/issues/212

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nvimpager
" autocmd User PageOpen,PageOpenFile
" 			\ nnoremap <silent> <nowait> g gg
" https://github.com/I60R/page?tab=readme-ov-file#nviminitlua-customizations-pager-only



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ builtin script (filetype-plugin filetype-indent syntax)
" put these lines here because:
" open https://github.com/junegunn/vim-plug, search 'filetype'

filetype on
filetype plugin on
filetype indent off
syntax on
" see ':h :filetype-overview'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ overrule ftplugin with filetype autocmd
" ':h ftplugin-overrule'
" https://stackoverflow.com/questions/1413285/multiple-autocommands-in-vim

set commentstring=#%s
digraphs oo 9679
digraphs xx 215
digraphs -< 8592
digraphs -^ 8593

function All()

	set formatoptions=

	set tabstop=8
	set softtabstop=0
	set shiftwidth=8
	set noexpandtab
	set autoindent
	set copyindent
	set nosmarttab
	set preserveindent

endfunction
autocmd FileType * call All()

function Markdown()
	setlocal commentstring=●%s
	" ●○■□
endfunction
autocmd FileType markdown call Markdown()

function Qf()
	" setlocal nowinfixheight
	" wincmd =
	wincmd _
	nnoremap <buffer> <silent> <cr> <cr>:only<cr>
	nnoremap <buffer> <silent> <f3> :q<cr>
	nnoremap <buffer> <silent> q    :q<cr>
endfunction
autocmd FileType qf call Qf()

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ftplugin options
" let g:markdown_folding = 1
" let g:markdown_recommended_style = 0



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ filename autocmd
autocmd BufRead log.txt silent $

autocmd BufWritePost dirs,files silent !bookmarks

" autocmd BufRead,BufNewFile xresources* set filetype=xdefaults
" autocmd BufWritePost xresources* !xrdb % 2> /dev/null
