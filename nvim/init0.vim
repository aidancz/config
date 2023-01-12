" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ option
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ default / unwanted option will be comment out
"set clipboard+=unnamedplus

set guicursor=
"set cursorline
"set relativenumber
set list
set listchars=tab:\·\ ,				"u+00b7, middle dot
set listchars+=multispace:▫,lead:▫,trail:▫,	"u+25ab, white small square
"set conceallevel=0
"set concealcursor=""

set nohlsearch
set ignorecase
set smartcase

"set noexpandtab
set nosmarttab
"set tabstop=8			" ? column of whitespace \t		worth
"set softtabstop=0		" ? column of whitespace <tab>/<bs>	worth, 0 turn off this feature
"set shiftwidth=8		" ? column of whitespace indentation	worth
" https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
"set autoindent
set copyindent
set preserveindent
"set nosmartindent

set notimeout
"set timeoutlen=1000
set ttimeout
set ttimeoutlen=0
set scrolloff=2
au BufEnter * set fo-=c fo-=r fo-=o
" disable automatic comment on newline
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
"inoremap kj <esc>

noremap <c-j> 5<c-e>
noremap <c-k> 5<c-y>
noremap <c-h> 0
noremap <c-l> $
inoremap <c-j> <c-o>5<c-e>
inoremap <c-k> <c-o>5<c-y>
inoremap <c-h> <c-o>0
inoremap <c-l> <c-o>$

nnoremap <silent> <cr> :call append(line("."), "")<cr>j
nnoremap <silent> <s-cr> :call append(line(".")-1, "")<cr>k

nnoremap s :w<cr>
nnoremap q :q<cr>
nnoremap Q :qa!<cr>



let mapleader=" "

nnoremap <leader>e :e!<cr>
nnoremap <leader>u :ea 1f<cr>
nnoremap <leader>r :lat 1f<cr>
nnoremap <leader>y :let @+=@0<cr>
nnoremap <leader>q q
nnoremap <leader><leader> :keepp /<--><cr>"_ca<
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <leader>l :call CompileRunGcc()<cr>



autocmd Filetype markdown inoremap <buffer> ,f <esc>:keepp /<--><cr>"_ca<
autocmd Filetype markdown inoremap <buffer> ,1 #<space><cr><cr><--><esc>2kA
autocmd Filetype markdown inoremap <buffer> ,2 ##<space><cr><cr><--><esc>2kA
autocmd Filetype markdown inoremap <buffer> ,c ```<cr><--><cr>```<cr><cr><--><esc>4kA
autocmd Filetype markdown inoremap <buffer> ,x <esc>/<--><cr>"_daW
autocmd Filetype markdown inoremap <buffer> ,d <esc>/<--><cr>"_dap



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ compile function
func! CompileRunGcc()
	exe "w"
	if expand("%:e") == "md"
		exe "MarkdownPreview"
	elseif &filetype == "c"
		set splitbelow
		:sp
		:res -5
		term gcc % -o %< && time ./%<
	endif
endfunc
