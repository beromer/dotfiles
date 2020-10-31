set nocompatible

call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" [COLORSCHEME] "
try
  let g:gruvbox_italic=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_contrast_dark="hard"
  let g:gruvbox_guisp_fallback="bg"
  set background=dark
  colorscheme gruvbox
catch
endtry

" TIMEOUTS "
set timeoutlen=600
set ttimeoutlen=0

" UNWANTED MAPPINGS "
nnoremap Q <nop>
nnoremap q: <nop>

" CURSORS "
let &t_SI="\<Esc>[5 q"
if v:version > 704
  let &t_SR="\<Esc>[3 q"
endif 
let &t_EI="\<Esc>[2 q"

" OPTIONS "
set number
set wrap
syntax on
set mouse=a
set listchars=tab:▸\ ,eol:¬
set autoread
let fortran_free_source=1
set shortmess=I

" LOAD SPELLING DICT FOR COMPLETION "
set spell
set complete+=kspell
set nospell

" SEARCHING "
set incsearch
set hlsearch
set ignorecase
set smartcase

" CURSORS AND COLUMNS "
set cursorline
hi colorcolumn ctermbg=234
hi cursorcolumn ctermbg=234
hi CursorLine ctermbg=234 cterm=none
hi CursorLineNR ctermbg=234 cterm=none

" VERTICAL SPLIT STYLING "
hi VertSplit ctermbg=none cterm=none
set fillchars+=vert:\│

set nofoldenable

" DIFF STYLING"
set fillchars+=diff:\╳

hi nractive ctermbg=233
hi nrinactive ctermbg=234
"dim when leaving
au winLeave * silent! setlocal winhighlight=LineNr:nrinactive
au winLeave * silent! setlocal winhighlight=Normal:nrinactive
au FocusLost * silent! setlocal winhighlight=LineNr:nrinactive
au FocusLost * silent! setlocal winhighlight=Normal:nrinactive
"brighten when entering
au winEnter * silent! setlocal winhighlight=LineNr:nractive
au winEnter * silent! setlocal winhighlight=Normal:nractive
au FocusGained * silent! setlocal winhighlight=LineNr:nractive
au FocusGained * silent! setlocal winhighlight=Normal:nractive

" LEADER MAPS "
let mapleader=","
"save/quit"
nnoremap <Leader>q :qa!<CR>
"interface"
nnoremap <Leader>wr :set wrap!<CR>
nnoremap <Leader>y :set list!<CR>
"spelling"
nnoremap <Leader>ss :setlocal spell!<CR>
nnoremap <Leader>sn ]s
nnoremap <Leader>sp [s
"highlighting"
nnoremap <Leader>/ :noh<CR>
nnoremap <Space> :noh<CR>
"colorcolumn
nnoremap <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? join(range(&tw+1,&tw+1000),',') : "")<CR>

" TABS AND INDENTS "
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp set expandtab shiftwidth=2 tabstop=2
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 foldignore=
autocmd FileType vim set expandtab shiftwidth=2 tabstop=2 softtabstop=2 nofoldenable
autocmd FileType zsh set expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldignore=
autocmd FileType git set expandtab shiftwidth=4 tabstop=4 foldignore=
autocmd FileType mail set textwidth=0 nofoldenable
autocmd FileType mail setlocal spell
autocmd FileType text setlocal spell wrap linebreak tw=0 showbreak=…
autocmd FileType tex set textwidth=80 expandtab shiftwidth=2 tabstop=2 foldignore=
autocmd FileType tex let maplocalleader='\'
autocmd BufNewFile,BufRead *.tmx set filetype=sh

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'['.l:branchname.']':''
endfunction

set statusline=
set statusline+=%#CursorColumn#
set statusline+=%{StatuslineGit()}
set statusline+=\[%f\]
set statusline+=\ \[\ \L\E\S\S\ \M\O\D\E\ \]
set statusline+=%=
set statusline+=\ %y
set statusline+=\[%{&fileformat}\]
set statusline+=\[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\[%B\]
set statusline+=\ \[%v·%l/%L\]
set statusline+=\ 

set nowrite
set nomodifiable
set noswapfile
set nobackup nowritebackup
set noundofile
set readonly

set noshowmode
set noshowcmd
set shortmess+=F
