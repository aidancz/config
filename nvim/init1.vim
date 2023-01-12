" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug
call plug#begin(stdpath('data') . '/plugged')

" color
Plug 'lifepillar/vim-solarized8'

" file navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode'

" editor enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'aidancz/vim-barbaric'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-solarized8
set termguicolors

let hour = strftime("%H")
let dark_start = str2nr($dark_start)
let dark_end = str2nr($dark_end)
exe "set background=" . ((hour >= dark_start || hour <= dark_end)? "dark" : "light")

let g:solarized_visibility = "normal"
let g:solarized_diffmode = "normal"
let g:solarized_termtrans = 0

let g:solarized_statusline = "normal"
let g:solarized_italics = 0
let g:solarized_old_cursor_style = 0
let g:solarized_use16 = 0
let g:solarized_extra_hi_groups = 0

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

autocmd vimenter * ++nested colorscheme solarized8
"colorscheme solarized8

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf
"nnoremap <leader>ff :Files<cr>
"nnoremap <leader>fb :Buffers<cr>
"nnoremap <leader>fh :History<cr>

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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-table-mode
"nnoremap <leader>tm :TableModeToggle<cr>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ auto-pairs
let g:AutoPairsMapCh = 0
"let g:AutoPairsShortcutToggle = '<M-p>'
"let g:AutoPairsShortcutFastWrap = '<M-e>'
"let g:AutoPairsShortcutJump = '<M-n>'
"let g:AutoPairsShortcutBackInsert = '<M-b>'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ coc
""""""""let g:coc_global_extensions = ['coc-marketplace', 'coc-vimlsp', 'coc-json']
""""""""
""""""""set hidden
""""""""set updatetime=100
""""""""set shortmess+=c
""""""""
""""""""inoremap <silent><expr> <TAB>
""""""""	\ pumvisible() ? "\<C-n>" :
""""""""	\ <SID>check_back_space() ? "\<TAB>" :
""""""""	\ coc#refresh()
""""""""inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
""""""""function! s:check_back_space() abort
""""""""	let col = col('.') - 1
""""""""	return !col || getline('.')[col - 1]  =~# '\s'
""""""""endfunction
""""""""
""""""""inoremap <silent><expr> <c-o> coc#refresh()
""""""""
""""""""inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
""""""""
""""""""nmap <silent> [g <Plug>(coc-diagnostic-prev)
""""""""nmap <silent> ]g <Plug>(coc-diagnostic-next)
""""""""
""""""""nmap <silent> gd <Plug>(coc-definition)
""""""""nmap <silent> gy <Plug>(coc-type-definition)
""""""""nmap <silent> gi <Plug>(coc-implementation)
""""""""nmap <silent> gr <Plug>(coc-references)
""""""""
""""""""nnoremap <silent> <LEADER>o :call <SID>show_documentation()<CR>
""""""""function! s:show_documentation()
""""""""	if CocAction('hasProvider', 'hover')
""""""""		call CocActionAsync('doHover')
""""""""	else
""""""""		call feedkeys('K', 'in')
""""""""	endif
""""""""endfunction
"""""""""autocmd CursorHold * silent call CocActionAsync('highlight')
