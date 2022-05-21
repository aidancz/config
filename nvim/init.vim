" ===
" === system
" ===
"set clipboard=unnamedplus



" ===
" === editor behavior
" ===
set ignorecase
set smartcase

set noexpandtab
set tabstop=4      " ? column of whitespace \t worth
set nosmarttab
set softtabstop=0  " ? column of whitespace <Tab>/<Bs> worth
set shiftwidth=4   " ? column of whitespace indentation worth
" https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990

set autoindent
set copyindent
set preserveindent

"set relativenumber
"set cursorline
set list
set listchars=tab:\|\ ,trail:▫
set conceallevel=0

set scrolloff=2

set notimeout
set ttimeoutlen=0



" ===
" === basic mappings
" ===
" set <LEADER> as <Space>
let mapleader=" "

" open init.vim anytime
noremap <LEADER>vi :e $HOME/.config/nvim/init.vim<CR>

" press <Space> twice to jump to the next '<-->' and edit it
noremap <LEADER><LEADER> <Esc>/<--><CR>:noh<CR>"_c4l

" insert newline without entering insert mode
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

" search
noremap <LEADER><CR> :noh<CR>

" yank & put
vnoremap Y "+y
nnoremap <A-p> "+p
nnoremap <A-P> "+P

" undo
nnoremap M :e!<CR>
nnoremap U :ea 1f<CR>

" save & quit
map S :w<CR>
map q :q<CR>
map Q :qa!<CR>



" ===
" === cursor movement
" ===
noremap J 5j
noremap K 5k
noremap H 0
noremap L $

noremap <C-j> 5<C-e>
noremap <C-k> 5<C-y>
"noremap <C-h> <C-u>
"noremap <C-l> <C-d>

inoremap <C-l> <ESC>A



" ===
" === window management
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
" === markdown settings
" ===
source ~/.config/nvim/MD_Snippets.vim
noremap <LEADER>m :MarkdownPreviewToggle<CR>
"noremap <LEADER>m :InstantMarkdownPreview<CR>



" ===
" === compile function
" ===
"noremap <LEADER>l :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"	exec "w"
"	if &filetype == 'markdown'
"		exec "MarkdownPreview"
"	endif
"endfunc



" ===
" === install plugins with vim-plug
" ===
call plug#begin(stdpath('data') . '/plugged')



" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" color
Plug 'lifepillar/vim-solarized8'

" fileNavigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'

" markdown
"Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'wjaelee/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode'

" editor enhancement
Plug 'jiangmiao/auto-pairs'
"Plug 'rlue/vim-barbaric'



call plug#end()



" ===========================================================
" ==================== vim-plug settings ====================
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

"autocmd CursorHold * silent call CocActionAsync('highlight')



" ===
" === vim-solarized8
" ===
set termguicolors
set background=light

let g:solarized_visibility = "normal"
let g:solarized_diffmode = "normal"
let g:solarized_termtrans = 0

let g:solarized_statusline = "normal"
let g:solarized_italics = 0
let g:solarized_old_cursor_style = 0
let g:solarized_use16 = 0
let g:solarized_extra_hi_groups = 0

colorscheme solarized8



" ===
" === fzf
" ===
noremap <C-f> :Files<CR>
noremap <C-b> :Buffers<CR>
noremap <C-Space> :History<CR>



" ===
" === markdown-preview
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
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>



" ===
" === vimwiki
" ===
au filetype vimwiki silent! iunmap <buffer> <Tab>
" https://github.com/vimwiki/vimwiki/issues/845

let g:vimwiki_list = [
\ {'name': 'Di', 'path': '$AIDAN_KL/Di', 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path': '', 'auto_diary_index': 1},
\ {'name': 'Wi', 'path': '$AIDAN_KL/Wi', 'syntax': 'markdown', 'ext': '.md'}
\ ]

let g:vimwiki_global_ext = 0
let g:vimwiki_conceallevel = 0

nmap \ <Plug>VimwikiFollowLink
nmap <LEADER>wj <Plug>VimwikiSplitLink
