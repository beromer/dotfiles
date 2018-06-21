
set number
syntax on
set expandtab
set tabstop=4
autocmd fileType tex setlocal spell spelllang=en_us
set nocompatible
set laststatus=2
filetype plugin on
set ofu=syntaxcomplete#Complete
set incsearch
set hlsearch
set wrapscan
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
set shiftwidth=4
inoremap ;; <esc>
cnoremap ;; <esc>
vnoremap ;; <esc>
nnoremap <F2> :w<ENTER>
nnoremap <F3> :w !sudo tee %<ENTER>

set backupdir=~/.tmp
set directory=~/.tmp
