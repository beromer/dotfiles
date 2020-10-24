set nocompatible
" COLORSCHEME "
try
  let g:gruvbox_italic=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_contrast_dark="hard"
  let g:gruvbox_guisp_fallback="bg"
  set background=dark
  colorscheme gruvbox
  ""autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
catch
endtry

" CURSORS "
let &t_SI="\<Esc>[5 q"
if v:version > 704
  let &t_SR="\<Esc>[3 q"
endif 
let &t_EI="\<Esc>[2 q"

" OPTIONS "
set showcmd
set rnu
set wildmenu
set number
set nowrap
syntax on
set backspace=indent,eol,start
set nostartofline
set confirm
set ttyfast
set so=3
set mouse=a
set laststatus=2
set listchars=tab:▸\ ,eol:¬
set hidden
let fortran_free_source=1

" LOAD SPELLING DICT FOR COMPLETION "
set spell
set complete+=kspell
set nospell

" FILE EXPLORER "
let g:netrw_altv=1
let g:netrw_liststyle=1
let g:netrw_fastbrowse=0
let g:netrw_sort_by="exten"


" FOLDING "
let s:middot='↘'
""let s:middot='·'
let s:raquo='≣'
""let s:raquo='⇶'
""let s:raquo='⁆'
""let s:raquo='»'
let s:small_l='ℓ'
function! Myfoldtext()
  let l:lines='[' . (v:foldend - v:foldstart + 1) . ']'
  ""let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . l:lines . l:dashes . ': ' . l:first . ' '
  ""return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction
if has('folding')
  if has('windows')
    set fillchars+=fold:⇉
    ""set fillchars+=fold:·
  endif
  set foldmethod=indent 
  set foldlevelstart=0
  set foldtext=Myfoldtext()
  hi Folded ctermbg=234
endif
set foldmethod=indent 

" VIEWS "
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

" SEARCHING "
set incsearch
set hlsearch
set ignorecase
set smartcase

" SAVE BUFFER POSITION "
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" AUTOMATIC BRACKET MATCHING "
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap {<CR> {<CR>}<esc>O
inoremap ' ''<esc>i
inoremap " ""<esc>i

" POWERLINE "
set rtp+=/usr/share/vim/addons/plugin/
silent! python3 from powerline.vim import setup as powerline_setup
silent! python3 powerline_setup()
silent! python3 del powerline_setup

" CURSORS AND COLUMNS "
set cursorline
hi colorcolumn ctermbg=234
hi cursorcolumn ctermbg=234
hi CursorLine ctermbg=234 cterm=none
hi CursorLineNR ctermbg=234 cterm=none

" VERTICAL SPLIT STYLING "
hi VertSplit ctermbg=none cterm=none
set fillchars+=vert:\║
""set fillchars+=vert:\│

" DIFF STYLING"
set fillchars+=diff:\╳

" MAPS "
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map Y y$
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" LEADER MAPS "
let mapleader=","
"save/quit"
nnoremap <Leader>qa :qa<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
"buffers"
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>n :bn<CR>
"windows"
nnoremap <Leader>l :Vex!<CR>
nnoremap <Leader>h :Vex<CR>
nnoremap <Leader>j :Hex<CR>
nnoremap <Leader>k :Hex!<CR>
nnoremap <Leader>t :Tex<CR>
nnoremap <Leader>o :on<CR>
"columns/cursors"
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80,120" : "")<CR>
nnoremap <Leader>x :set cursorline!<CR>
nnoremap <Leader>z :set cursorcolumn!<CR>
"interface"
nnoremap <Leader>r :set rnu!<CR>
nnoremap <Leader>w :set wrap!<CR>
nnoremap <Leader>y :set list!<CR>
"spelling"
nnoremap <Leader>s :setlocal spell!<CR>
"highlighting"
nnoremap <Leader>/ :noh<CR>
nnoremap <Space> :noh<CR>
"quickfix"
nnoremap <silent> <leader>m :make!<CR>:cw 5<CR>
nnoremap <leader>a :cn<CR>
nnoremap <leader>aa :cp<CR>
nnoremap <leader>d :cr<CR>

" MAKE "
set makeprg=ninja
set autowrite

" TABS AND INDENTS "
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp set expandtab shiftwidth=2 tabstop=2
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 foldignore=
autocmd FileType vim set expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldignore=

" BACKUP, SWAP AND UNDO DIRECTORIS "
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
