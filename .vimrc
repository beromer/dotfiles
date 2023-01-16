set nocompatible
syntax enable
filetype plugin on

set path+=**
set wildmenu

let g:netrw_sizestyle= "h"

set backspace=indent,eol,start

set mouse=a

set hidden autoread

set noswapfile nobackup nowritebackup

set incsearch " hlsearch
set ignorecase smartcase

set tabstop=4 shiftwidth=4
set expandtab autoindent smartindent

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp set expandtab shiftwidth=2 tabstop=2
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 foldignore=
let fortran_free_source=1
