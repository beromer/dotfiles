syntax enable
colorscheme solarized

set nocompatible
set showcmd
set rnu

set number
set nowrap
syntax on
set expandtab
set tabstop=4
set shiftwidth=4
set foldmethod=syntax
set foldlevelstart=20

set incsearch
set hlsearch
set ignorecase
set smartcase

set mouse=a

set colorcolumn=80
let &colorcolumn="120,".join(range(121,1499),",")

set rtp+=/usr/share/vim/addons/plugin/
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2
set cursorline
hi colorcolumn ctermbg=232
hi cursorcolumn ctermbg=232
hi cursorline ctermbg=232 cterm=none
hi cursorlinenr cterm=none


hi VertSplit cterm=none
set fillchars+=vert:\▏


map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
nmap <C-@> :bn<CR>
nnoremap <Leader>b :ls<CR>:b<Space>
set hidden
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim","",0770)
endif
if !isdirectory($HOME."/.vim/backupdir")
    call mkdir($HOME."/.vim/backupdir","",0700)
endif
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir","",0700)
endif

set backupdir=~/.vim/backupdir
set directory=~/.vim/backupdir
set undodir=~/.vim/undodir
let fortran_free_source=1

exe "hi! Comment cterm=italic"
hi! Comment cterm=italic
hi Comment cterm=italic
