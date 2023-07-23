syntax on
set number
set relativenumber
set list
set listchars=eol:\ ,
set virtualedit=onemore,block
au InsertLeave * :norm `^
set listchars+=tab:\·\ ,			"u+00b7, middle dot
"set listchars+=multispace:▫,lead:▫,trail:▫,	"u+25ab, white small square
set shortmess-=S

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
" https://gist.github.com/pironim/3722006

set ignorecase
set smartcase

set clipboard^=unnamedplus

set notimeout			" ex: zz
"set timeoutlen=1000
set ttimeout			" <esc>
set ttimeoutlen=0
au BufEnter * set fo-=c fo-=r fo-=o
" disable automatic comment on newline
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

set hidden



nnoremap <silent> <c-j> :put _<cr>
nnoremap <silent> <c-k> :put! _<cr>
nnoremap <silent> <esc>j :m +1<cr>
nnoremap <silent> <esc>k :m -2<cr>

map Y y$

let mapleader=" "



let g:less = {}
let g:vimpager = {}
let g:less.scrolloff = 1024
" https://github.com/rkitover/vimpager/issues/212



autocmd BufWritePost mdir,mfile !mdir-mfile %
autocmd BufWritePost xresources !xrdb % 2> /dev/null
