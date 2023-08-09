" setup folds{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" https://github.com/iggredible/Learn-Vim/blob/master/ch22_vimrc.md#keeping-one-vimrc-file
"}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug_install

" # https://github.com/junegunn/vim-plug
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" run ":PlugInstall" inside nvim to install the plugs
" https://github.com/junegunn/vim-plug#commands

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug_config
call plug#begin(stdpath('data') . '/plugged')

" appearance
Plug 'altercation/vim-colors-solarized'
Plug 'ap/vim-css-color'

" editor enhancement
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'aidancz/vim-barbaric'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" file navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ plug_config

" solarized{{{
"let g:solarized_termcolors=16
"let g:solarized_termtrans=0
"let g:solarized_degrade=0
"let g:solarized_bold=1
"let g:solarized_underline=1
"let g:solarized_italic=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"
set background=dark
" always set this option to "dark", let the terminal decide dark or light
colorscheme solarized
call togglebg#map("<F2>")
"}}}

" auto-pairs{{{
let g:AutoPairsMapCh = 0
"let g:AutoPairsShortcutToggle = '<M-p>'
"let g:AutoPairsShortcutFastWrap = '<M-e>'
"let g:AutoPairsShortcutJump = '<M-n>'
"let g:AutoPairsShortcutBackInsert = '<M-b>'
"}}}

" coc{{{

"" curl -sL install-node.vercel.app/lts | bash
"" https://github.com/neoclide/coc.nvim#quick-start

"let g:coc_global_extensions = ['coc-marketplace', 'coc-vimlsp', 'coc-json']

"set hidden
"set updatetime=100
"set shortmess+=c

"inoremap <silent><expr> <TAB>
"	\ pumvisible() ? "\<C-n>" :
"	\ <SID>check_back_space() ? "\<TAB>" :
"	\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"function! s:check_back_space() abort
"	let col = col('.') - 1
"	return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"inoremap <silent><expr> <c-o> coc#refresh()

"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"nnoremap <silent> <LEADER>o :call <SID>show_documentation()<CR>
"function! s:show_documentation()
"	if CocAction('hasProvider', 'hover')
"		call CocActionAsync('doHover')
"	else
"		call feedkeys('K', 'in')
"	endif
"endfunction
""autocmd CursorHold * silent call CocActionAsync('highlight')
"}}}

" fzf{{{
"nnoremap <leader>ff :Files<cr>
"nnoremap <leader>fb :Buffers<cr>
"nnoremap <leader>fh :History<cr>
"}}}

" markdown-preview{{{
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
	silent exec "!google-chrome-stable --new-window " . a:url . " &"
endfunction
"}}}

" vim-table-mode{{{
nnoremap <leader>tm :TableModeToggle<cr>
"}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
let mapleader=" "

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ autocmd
autocmd BufWritePost mdir,mfile !mdf
autocmd BufRead,BufNewFile xresources* set filetype=xdefaults
autocmd BufWritePost xresources* !xrdb % 2> /dev/null

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ compile function
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
nnoremap <f5> :call CompileRunGcc()<cr>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ source
source $XDG_CONFIG_HOME/.vim/vim-nvim.vim
