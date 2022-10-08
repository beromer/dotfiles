set nocompatible
syntax on
set showcmd
set rnu
set wildmenu
set number
set nowrap
set backspace=indent,eol,start
set nostartofline
set confirm
set ttyfast
set so=3
set mouse=a
set laststatus=2
set listchars=tab:▸\ ,eol:¬
set hidden
set autoread
let fortran_free_source=1
set splitbelow
set shortmess=I
set noswapfile
set nobackup nowritebackup

map Y y$

set incsearch
set hlsearch
set ignorecase
set smartcase

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp set expandtab shiftwidth=2 tabstop=2
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 foldignore=
