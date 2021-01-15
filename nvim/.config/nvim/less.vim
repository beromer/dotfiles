set nocompatible

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
syntax on
set mouse=a
set autoread
let fortran_free_source=1

" LOAD SPELLING DICT FOR COMPLETION "
set spell
set complete+=kspell
set nospell

" SEARCHING "
set incsearch
set hlsearch
set ignorecase
set smartcase

set nofoldenable

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

nnoremap <Space> <C-f>

"set nowrite
set nobackup nowritebackup
set noundofile

set noshowmode
set noshowcmd
set noruler
set laststatus=0

setlocal noswapfile buftype=nofile bufhidden=hide
setlocal nomodified readonly nomodifiable
setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
setlocal wrap breakindent linebreak
setlocal iskeyword+=-

setlocal nonumber norelativenumber
setlocal foldcolumn=0 colorcolumn=0 nolist nofoldenable

setlocal tagfunc=man#goto_tag

nnoremap <silent> <buffer> j          <C-e>
nnoremap <silent> <buffer> k          <C-y>
nnoremap <silent> <buffer> gO         :call man#show_toc()<CR>
nnoremap <silent> <buffer> <nowait> q :lclose<CR>:q<CR>

let b:did_ftplugin = 1
