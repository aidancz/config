source ~/.config/.vim/vim-nvim.vim

let g:less = {}
let g:vimpager = {}
let g:less.scrolloff = 1024
" https://github.com/rkitover/vimpager/issues/212

autocmd BufWritePost mdir,mfile !mdir-mfile %
autocmd BufWritePost xresources !xrdb % 2> /dev/null
