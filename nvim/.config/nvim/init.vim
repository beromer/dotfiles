set nocompatible

" [BRACKETS] '
vnoremap i] "sdi[]<esc>P
vnoremap i} "sdi{}<esc>P
vnoremap i) "sdi()<esc>P
vnoremap " "sdi""<esc>P
vnoremap ' "sdi''<esc>P
inoremap{<CR> {<CR>}<ESC>O<tab>

" [HIGHLIGHT YANK] "
if has('nvim')
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
  augroup END
endif 

" AUTOCOMPLETE "
set path+=**
set completeopt+=longest,menuone,noinsert
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
    "if pumvisible()
        return "\<C-n>"
    else
        return "\<Tab>"
    endif
endfun
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
set autowrite
set noshowmode
set showcmd
set rnu
set wildmenu
set number
set nowrap
syntax on
filetype plugin indent on
set backspace=indent,eol,start
set nostartofline
set confirm
set ttyfast
set so=3
set mouse=a
set laststatus=2
set listchars=tab:▏\ 
set listchars+=extends:
set listchars+=precedes:
set listchars+=trail:█
set hidden
set autoread
let fortran_free_source=1
let fortran_do_enddo=1
set splitbelow
set splitright
set shortmess=IcF
autocmd vimenter * wincmd l
set undofile
set shiftround

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


" VERTICAL SPLIT STYLING "
set fillchars+=vert:\│

set fillchars+=stl:=

" DIFF STYLING"
set fillchars+=diff:\╳

" LEADER MAPS "
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>r :so ~/.config/nvim/init.vim<CR>

"colorcolumn
nnoremap <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? join(range(&tw+1,&tw+1000),',') : "")<CR>


" TABS AND INDENTS "
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType fortran setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType python setlocal noexpandtab shiftwidth=4 tabstop=4 nofoldenable list
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 nofoldenable
autocmd FileType zsh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldignore=
autocmd FileType git setlocal expandtab shiftwidth=4 tabstop=4 foldignore= spell complete+=kspell
autocmd FileType mail setlocal textwidth=0 nofoldenable spell complete+=kspell
autocmd FileType text setlocal spell wrap linebreak tw=0 showbreak=… complete+=kspell
autocmd FileType tex setlocal textwidth=80 expandtab shiftwidth=2 tabstop=2 foldignore= spell complete+=kspell
autocmd BufNewFile,BufRead *.tmx set filetype=sh

set statusline=
set statusline+=%#Normal#
set statusline+=\%y
set statusline+=\[%f\]
set statusline+=%m
set statusline+=%=
set statusline+=\[%l/%L\]

nnoremap <Space> <C-f>
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" ColorScheme
highlight clear
if exists("syntax_on")
  syntax reset
endif
highlight DiffAdd        ctermfg=0    ctermbg=2
highlight DiffChange     ctermfg=0    ctermbg=3
highlight DiffDelete     ctermfg=0    ctermbg=1
highlight DiffText       ctermfg=0    ctermbg=11   cterm=bold
highlight Visual         ctermfg=NONE ctermbg=NONE cterm=inverse
highlight Search         ctermfg=0    ctermbg=11
highlight SpecialKey     ctermfg=4
highlight TermCursor     cterm=reverse
highlight NonText        ctermfg=12
highlight Directory      ctermfg=4
highlight ErrorMsg       ctermfg=15 ctermbg=1
highlight IncSearch      cterm=reverse
highlight MoreMsg        ctermfg=2
highlight ModeMsg        cterm=bold
highlight CursorLineNr   ctermfg=3
highlight Question       ctermfg=2
highlight Title          ctermfg=5
highlight WarningMsg     ctermfg=1
highlight WildMenu       ctermfg=0 ctermbg=11
highlight Conceal        ctermfg=7 ctermbg=7
highlight SpellBad       ctermbg=9
highlight SpellRare      ctermbg=13
highlight SpellLocal     ctermbg=14
highlight PmenuSbar      ctermbg=8
highlight PmenuThumb     ctermbg=0
highlight TabLine        cterm=underline ctermfg=0 ctermbg=7
highlight TabLineSel     cterm=bold
highlight TabLineFill    cterm=reverse
highlight CursorColumn   ctermbg=7
highlight CursorLine     cterm=underline
highlight MatchParen     ctermbg=14
highlight Constant       ctermfg=5
highlight Special        ctermfg=5
highlight Identifier     cterm=NONE ctermfg=6
highlight Statement      ctermfg=3
highlight PreProc        ctermfg=5
highlight Type           ctermfg=2
highlight Underlined     cterm=underline ctermfg=5
highlight Ignore         ctermfg=15
highlight Error          ctermfg=15 ctermbg=9
highlight Todo           ctermfg=0 ctermbg=11
highlight LineNr         ctermfg=8
highlight Comment        ctermfg=8
highlight ColorColumn    ctermfg=7    ctermbg=8
highlight Folded         ctermfg=7    ctermbg=0
highlight FoldColumn     ctermfg=7    ctermbg=8
highlight Pmenu          ctermfg=15   ctermbg=8
highlight PmenuSel       ctermfg=8    ctermbg=15
highlight SpellCap       ctermfg=7    ctermbg=8
highlight StatusLine     ctermfg=15   ctermbg=8    cterm=bold
highlight StatusLineNC   ctermfg=7    ctermbg=8    cterm=NONE
highlight VertSplit      ctermfg=7    ctermbg=8    cterm=NONE
highlight SignColumn                  ctermbg=8
