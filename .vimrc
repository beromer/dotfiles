function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

"function! GitBranchMod()
"    return system("[[ -n \"$(git status --porcelain " . shellescape(expand("%")) . ")\" ]] && echo -n +")
"endfunction
"
"function! StatuslineGitMod()
"  let l:branchname = GitBranchMod()
"  return strlen(l:branchname) < 2?'  '.l:branchname.' ':''
"endfunction

set statusline=
set statusline+=%#StatusLine#
set statusline+=%{StatuslineGit()}
"set statusline+=%{StatuslineGitMod()}
set statusline+=%#StatusLineNC#
set statusline+=\ %f\ %m%r\[%n\]
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=%#StatusLineNC#
set statusline+=\ %y
set statusline+=\[%{&fileformat}\]
set statusline+=\[%{&fileencoding?&fileencoding:&encoding},%B\]
set statusline+=\ 
set statusline+=%#StatusLine#
set statusline+=\ %l/%L:%v
set statusline+=\ 

syntax enable
try
    colorscheme solarized
catch
endtry
set background=dark

set nocompatible
set showcmd
set rnu
set wildmenu

let g:netrw_altv=1
let g:netrw_liststyle=1
let g:netrw_fastbrowse=0
let g:netrw_sort_by="exten"

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

set autoindent
set smartindent
set backspace=indent,eol,start
set nostartofline
set confirm
set ttyfast

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap {<CR> {<CR>}<esc>O
inoremap ' ''<esc>i
inoremap " ""<esc>i

map Y y$
set listchars=tab:▸\ ,eol:¬

set so=3

set mouse=a

"set colorcolumn=80

"set rtp+=/usr/share/vim/addons/plugin/
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup


set laststatus=2
set cursorline
hi colorcolumn ctermbg=232
hi cursorcolumn ctermbg=232
hi cursorline ctermbg=232 cterm=none
hi cursorlinenr cterm=none


"hi VertSplit ctermbg=none cterm=none
set fillchars+=vert:\│
"set fillchars+=vert:\▏


map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

let mapleader=","
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>l :Vex!<CR>
nnoremap <Leader>h :Vex<CR>
nnoremap <Leader>j :Hex<CR>
nnoremap <Leader>k :Hex!<CR>
nnoremap <Leader>t :Tex<CR>
nnoremap <Leader>o :on<CR>
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80,120" : "")<CR>
nnoremap <Leader>x :set cursorline!<CR>
nnoremap <Leader>z :set cursorcolumn!<CR>
nnoremap <Leader>r :set rnu!<CR>
nnoremap <Leader>w :set wrap!<CR>
nnoremap <Leader>y :set list!<CR>
nnoremap <Leader>s :setlocal spell!<CR>
nnoremap <Leader>/ :noh<CR>
nnoremap <Space> :noh<CR>

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

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
set undofile
let fortran_free_source=1

