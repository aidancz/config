" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ option
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ nocompatible
"set nocompatible
" archlinux has a default vim config at "/usr/share/vim/vimfiles/archlinux.vim", this option has been set there
" find the location via ":verbose set compatible?"
" if no user vimrc is found, this option will also be set via "default.vim", see ":h defaults.vim"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
set number
set relativenumber
set guicursor=
"set cursorline
set wildmenu
set wildoptions="pum,tagfile"
set shortmess-=S
set showcmd

syntax on
set list
set listchars=eol:\ ,
set virtualedit=onemore,block
au InsertLeave * :norm `^
set listchars+=tab:\·\ ,			"u+00b7, middle dot
"set listchars+=multispace:▫,lead:▫,trail:▫,	"u+25ab, white small square

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
" https://gist.github.com/pironim/3722006

set concealcursor=""
set conceallevel=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ keypress time
set notimeout			" eg: zz
set timeoutlen=100		" based on "timeout", has no effect if "notimeout"
set ttimeout			" <esc>
set ttimeoutlen=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search
set nohlsearch
set incsearch
set ignorecase
set smartcase
set magic

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ copy
set clipboard^=unnamedplus

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ indent
set tabstop=8			" ? column of whitespace \t		worth
set softtabstop=0		" ? column of whitespace <tab>/<bs>	worth, 0 turns off this feature
set shiftwidth=8		" ? column of whitespace >>/<<		worth
" we abbreviate "? column of whitespace" as "indent" below
" https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

set noexpandtab			" expandtab: replace '\t' with ' '

set autoindent			" autoindent: when create a new line, copy indent from the line above
set copyindent			" copyindent: based on "autoindent", when create a new line, copy indent (use same whitespace chars) from the line above
" let's say we have "▫▫▫·alice and bob"
" "autoindent": "·▫▫▫█"
" "autoindent" & "copyindent": "▫▫▫·█"

set nosmarttab			" smarttab: at line start, use shiftwidth instead of softtabstop
set preserveindent		" preserveindent: at line start, when use >>/<<, preserve current indent
" let's say we have "▫▫▫·alice and bob"
" "preserveindent": "▫▫▫·▫▫▫·alice and bob"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ formatoptions (automatic formatting)
"au BufEnter * set fo-=c fo-=r fo-=o
" disable automatic comment on newline
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ buffer window tab
set scrolloff=0
set hidden



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
nnoremap <expr> zh 'zt' . winheight(0)/4 . '<c-y>'
nnoremap <expr> zl 'zb' . winheight(0)/4 . '<c-e>'
" https://stackoverflow.com/questions/8059448/scroll-window-halfway-between-zt-and-zz-in-vim

nnoremap Y y$

nnoremap <silent> <c-j> :put _<cr>
nnoremap <silent> <c-k> :put! _<cr>
nnoremap <silent> <esc>j :m +1<cr>
nnoremap <silent> <esc>k :m -2<cr>
