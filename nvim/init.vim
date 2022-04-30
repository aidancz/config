" ===
" === System
" ===
"set clipboard=unnamedplus



" ===
" === Editor behavior
" ===
set ignorecase
set smartcase

set autoindent
set copyindent
"set preserveindent
set tabstop=8
set softtabstop=0
set shiftwidth=8
set noexpandtab

"set relativenumber
"set cursorline
set list
set listchars=tab:\|\ ,trail:▫
"set conceallevel=0

set scrolloff=2

set notimeout
set ttimeoutlen=0



" ===
" === Basic Mappings
" ===
" Set <LEADER> as <Space>
let mapleader=" "

" Open init.vim anytime
noremap <LEADER>vi :e $HOME/.config/nvim/init.vim<CR>

" Press <Space> twice to jump to the next '<-->' and edit it
noremap <LEADER><LEADER> <Esc>/<--><CR>:noh<CR>"_c4l

" Insert newline without entering insert mode
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

" Search
noremap <LEADER><CR> :noh<CR>

" Yank & Put
vnoremap Y "+y

" Save & Quit
map S :w<CR>
map q :q<CR>
map Q :qa!<CR>



" ===
" === Cursor Movement
" ===
noremap J 5j
noremap K 5k
noremap H 0
noremap L $

noremap <C-j> 5<C-e>
noremap <C-k> 5<C-y>
noremap <C-h> <C-u>
noremap <C-l> <C-d>

inoremap <C-l> <ESC>A



" ===
" === Window Management
" ===
noremap s <nop>
map sj :set sb<CR>:sp<CR>
map sk :set nosb<CR>:sp<CR>
map sh :set nospr<CR>:vs<CR>
map sl :set spr<CR>:vs<CR>

map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l

map <down> :res -5<CR>
map <up> :res +5<CR>
map <left> :vert res -5<CR>
map <right> :vert res +5<CR>



" ===
" === Markdown Settings
" ===
source ~/.config/nvim/MD_Snippets.vim
noremap M :MarkdownPreviewToggle<CR>
"noremap M :InstantMarkdownPreview<CR>



" ===
" === Compile Function
" ===
"noremap <LEADER>l :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"	exec "w"
"	if &filetype == 'markdown'
"		exec "MarkdownPreview"
"	endif
"endfunc



" ===
" === Install Plugins with Vim-Plug
" ===
call plug#begin(stdpath('data') . '/plugged')



" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Color
Plug 'overcache/NeoSolarized'

" FileNavigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
"Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'dhruvasagar/vim-table-mode'



call plug#end()



" ===========================================================
" ==================== Vim-Plug Settings ====================
" ===========================================================
" ===
" === coc
" ===
let g:coc_global_extensions = ['coc-marketplace', 'coc-vimlsp', 'coc-json']

set hidden
set updatetime=100
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-o> coc#refresh()

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <LEADER>o :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')



" ===
" === NeoSolarized
" ===
set termguicolors
"set background=dark
set background=light

let g:neosolarized_contrast = "normal"
let g:neosolarized_visibility = "normal"
let g:neosolarized_vertSplitBgTrans = 1
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 0
let g:neosolarized_termBoldAsBright = 1

colorscheme NeoSolarized



" ===
" === fzf
" ===
noremap <C-f> :Files<CR>
noremap <C-b> :Buffers<CR>
noremap <C-Space> :History<CR>



" ===
" === markdown-preview.nvim
" ===
function! g:Open_browser(url)
	silent exec "!google-chrome-stable --new-window " . a:url . " &"
endfunction

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



" ===
" === vim-instant-markdown
" ===
"filetype plugin on
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_browser = "google-chrome-stable --new-window"



" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>



" ===
" === vimwiki
" ===
let g:vimwiki_list = [{'path': '$AIDAN_AC/Vw',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0
let g:vimwiki_conceallevel = 0

nnoremap <LEADER>wl <Plug>VimwikiFollowLink
nnoremap <LEADER>wj <Plug>VimwikiSplitLink
