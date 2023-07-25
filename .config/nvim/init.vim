source ~/.config/.vim/vim-nvim.vim

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



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-plug
call plug#begin(stdpath('data') . '/plugged')

" visual
Plug 'altercation/vim-colors-solarized'
Plug 'ap/vim-css-color'

" file navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode'

" editor enhancement
	" general
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
	" chinese
Plug 'aidancz/vim-barbaric'
	" complete
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ solarized
"let g:solarized_termcolors=16
"let g:solarized_termtrans=0
"let g:solarized_degrade=0
"let g:solarized_bold=1
"let g:solarized_underline=1
"let g:solarized_italic=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"
set background=dark
colorscheme solarized
call togglebg#map("<F5>")

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

function! g:Open_browser(url)
	silent exec "!google-chrome-stable --new-window " . a:url . " &"
endfunction

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ vim-table-mode
nnoremap <leader>tm :TableModeToggle<cr>

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
