set nocompatible
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" [BRACKETS] '
vnoremap i] "sdi[]<esc>P
vnoremap i} "sdi{}<esc>P
vnoremap i) "sdi()<esc>P
vnoremap " "sdi""<esc>P
vnoremap ' "sdi''<esc>P
inoremap{<CR> {<CR>}<ESC>O<tab>

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

" [HIGHLIGHT YANK] "
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
augroup END


" AUTOCOMPLETE "
set path+=**
set completeopt+=longest,menuone,noinsert
" Minimalist-TabComplete-Plugin
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    "if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<Tab>"
    endif
endfun

" Minimalist-AutoCompletePop-Plugin
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 3] =~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'

        call feedkeys("\<C-n>", 'n')
    end
endfun


" [TIMEOUTS] "
set timeoutlen=750
set ttimeoutlen=0

" [UNWANTED MAPPINGS] "
nnoremap Q <nop>
nnoremap q: <nop>

" [CURSORS] "
let &t_SI="\<Esc>[5 q"
if v:version > 704
  let &t_SR="\<Esc>[3 q"
endif 
let &t_EI="\<Esc>[2 q"

" [OPTIONS] "
set noshowmode
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
set listchars=tab:▸-
set listchars=tab:▸-,eol:¬
set hidden
set autoread
let fortran_free_source=1
let fortran_do_enddo=1
set splitbelow
set splitright
set shortmess=IcF
autocmd vimenter * wincmd l
set undofile

" [LOAD SPELLING DICT FOR COMPLETION] "
set spell
set nospell

" [FILE EXPLORER] "
let g:netrw_altv=1
let g:netrw_browse_split=4
"let g:netrw_liststyle=1
let g:netrw_liststyle=3
let g:netrw_fastbrowse=0
let g:netrw_sort_by="exten"

" FOLDING "
let s:fsym='↘'
let s:lsym='≣'
let s:small_l='ℓ'
function! Myfoldtext()
  let l:lines='[' . (v:foldend - v:foldstart + 1) . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:fsym, 'g')
  return s:lsym . l:lines . l:dashes . ': ' . l:first . ' '
endfunction
if has('folding')
  if has('windows')
    set fillchars+=fold:·
  endif
  set foldmethod=indent 
  set foldlevelstart=0
  set foldtext=Myfoldtext()
  hi Folded ctermbg=234
endif
set foldmethod=indent 

" VIEWS "
set viewoptions=cursor,folds
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

map Y y$
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

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

set fillchars=stl:=

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

function! CloseOnLast()
    bdelete
    let cnt = 0
    for i in range(0, bufnr("$"))
        if buflisted(i) && ! empty(bufname(i))
            let cnt += 1
        endif
    endfor
    if cnt <= 1
        quit
    endif
endfunction

function! Quitiflast()
    let bufcnt = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    if bufcnt < 2
        echo 'shutting everything down'
        quit
    else
        bdelete
    endif
endfun

" LEADER MAPS "
nnoremap <Leader>v :e $MYVIMRC<CR>

"buffers"
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

"interface"
nnoremap <Leader>r :so ~/.config/nvim/init.vim<CR>

"colorcolumn
nnoremap <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? join(range(&tw+1,&tw+1000),',') : "")<CR>

" MAKE "
set makeprg=ninja
set autowrite

" TABS AND INDENTS "
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType fortran setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType python setlocal noexpandtab shiftwidth=4 tabstop=4 foldignore=
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 nofoldenable
autocmd FileType zsh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldignore=
autocmd FileType git setlocal expandtab shiftwidth=4 tabstop=4 foldignore= spell complete+=kspell
autocmd FileType mail setlocal textwidth=0 nofoldenable spell complete+=kspell
autocmd FileType text setlocal spell wrap linebreak tw=0 showbreak=… complete+=kspell
autocmd FileType tex setlocal textwidth=80 expandtab shiftwidth=2 tabstop=2 foldignore= spell complete+=kspell
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
"set statusline+=%{FugitiveStatusline()}
set statusline+=\[%f\]
set statusline+=%m
set statusline+=%=
set statusline+=\%y
set statusline+=\[%{&fileformat}\]
set statusline+=\[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\[%B\]
set statusline+=\ \[%v·%l/%L\]
set statusline+=\ 
