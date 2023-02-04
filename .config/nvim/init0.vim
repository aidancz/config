" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ option
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ default / unwanted option will be comment out
set clipboard^=unnamedplus

set guicursor=
"set cursorline
set number
set relativenumber
set list
set listchars=eol:\ ,
au InsertLeave * :norm `^
set virtualedit=onemore,block
set listchars+=tab:\·\ ,			"u+00b7, middle dot
set listchars+=multispace:▫,lead:▫,trail:▫,	"u+25ab, white small square
"set conceallevel=0
"set concealcursor=""

set nohlsearch
"set incsearch
set ignorecase
set smartcase
"set magic

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

set notimeout			" ex: zz
"set timeoutlen=1000
set ttimeout			" <esc>
set ttimeoutlen=0
"set scrolloff=0
au BufEnter * set fo-=c fo-=r fo-=o
" disable automatic comment on newline
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines

"set hidden



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
"inoremap kj <esc>
inoremap <c-h> <c-o>0
inoremap <c-l> <c-o>$
inoremap <c-w> <c-g>u<c-w>
inoremap <c-u> <c-g>u<c-u>

nnoremap s :w<cr>
nnoremap q :q<cr>
nnoremap <silent> J :m +1<cr>
nnoremap <silent> K :m -2<cr>
nnoremap <expr> zh 'zt' . winheight(0)/4 . '<c-y>'
nnoremap <expr> zl 'zb' . winheight(0)/4 . '<c-e>'

nnoremap <c-q> q
nnoremap <c-j> <c-d>
nnoremap <c-k> <c-u>

nnoremap <silent> <a-j> :put _<cr>
nnoremap <silent> <a-k> :put! _<cr>



let mapleader=" "

nnoremap <leader>e :e!<cr>
nnoremap <leader>u :ea 1f<cr>
nnoremap <leader>r :lat 1f<cr>
nnoremap <leader>l :call CompileRunGcc()<cr>
nnoremap <leader><leader> :keepp /<--><cr>"_ca<



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



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ luke smith
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb % 2> /dev/null
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
