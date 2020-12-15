set nocompatible

call plug#begin()
"Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
call plug#end()

" VIMTEX "
let g:tex_flavor = 'latex'
let g:vimtex_enabled = 1
let g:vimtex_view_general_viewer='zathura'

vnoremap ] "sdi[]<esc>P
vnoremap } "sdi{}<esc>P
vnoremap ) "sdi()<esc>P
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

"augroup highlight_yank
"    autocmd!
"    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
"augroup END
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
augroup END
"
"au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
"let g:highlightedyank_highlight_duration = 1000

"autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank('IncSearch', 200)
set noshowmode

" FZF SETUP "
let g:fzf_buffers_jump = 1
"let g:fzf_layout = { 'window': '10new' }

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
"set listchars=tab:▸\ ,eol:¬
set hidden
set autoread
let fortran_free_source=1
let fortran_do_enddo=1
set splitbelow
set shortmess=I
autocmd vimenter * wincmd l
set undofile

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
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

cabbrev h vert bo h
map Y y$
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" SEARCHING "
set incsearch
set hlsearch
set ignorecase
set smartcase

" SAVE BUFFER POSITION "
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" CURSORS AND COLUMNS "
set cursorline
hi colorcolumn ctermbg=234
hi cursorcolumn ctermbg=234
hi CursorLine ctermbg=234 cterm=none
hi CursorLineNR ctermbg=234 cterm=none

" VERTICAL SPLIT STYLING "
hi VertSplit ctermbg=none cterm=none
"set fillchars+=vert:\║
set fillchars+=vert:\│

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
nnoremap <Leader>V :e $MYVIMRC<CR>
"save/quit"
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>ww :w<CR>
nnoremap <Leader>wq :wqa<CR>
"buffers"
nnoremap <Leader>bl :ls<CR>:b<Space>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bb <C-^>
nnoremap <Leader>bq :bd<CR>

"windows"
nnoremap <Leader>sl :Vex!<CR>
nnoremap <Leader>sh :Vex<CR>
nnoremap <Leader>sj :Hex<CR>
nnoremap <Leader>sk :Hex!<CR>
nnoremap <Leader>st :Tex<CR>
nnoremap <Leader>so :on<CR>
nnoremap <Leader>c :close<CR>
"interface"
nnoremap <Leader>R :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>r :set rnu!<CR>
nnoremap <Leader>wr :set wrap!<CR>
nnoremap <Leader>y :set list!<CR>
"spelling"
nnoremap <Leader>ss :setlocal spell!<CR>
nnoremap <Leader>sn ]s
nnoremap <Leader>sp [s
nnoremap <Leader>sc z=
"diff"
nnoremap <Leader>dn ]c
nnoremap <Leader>dp [c
nnoremap <Leader>do :diffget<CR>
"highlighting"
nnoremap <Leader>/ :noh<CR>
nnoremap <Space> :noh<CR>
"quickfix"
"nnoremap <silent> <leader>m :make!<CR>:cw 5<CR>
"nnoremap <leader>en :cn<CR>
"nnoremap <leader>ep :cp<CR>
"nnoremap <leader>ef :cr<CR>
"coc.nvim"
nmap <silent> <leader>en <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ep <Plug>(coc-diagnostic-next)

"fzf"
nnoremap <leader>o :FZF ..<CR>
nnoremap <leader>fo :Files! ..<CR>
nnoremap <leader>O :FZF ~<CR>
nnoremap <leader>fO :Files! ~<CR>
nnoremap <leader>ff :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fa :Lines<CR>
nnoremap <leader>fh :History:<CR>
"fugitive"
nnoremap <LEADER>gg :G<CR>
"vimtex
nnoremap <LEADER>vc :w<CR>:VimtexCompile<CR>:VimtexCompile<CR>
nnoremap <LEADER>vv :w<CR>:VimtexCompile<CR>
"colorcolumn
nnoremap <leader>gc :execute "set colorcolumn=" . (&colorcolumn == "" ? join(range(&tw+1,&tw+1000),',') : "")<CR>

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
autocmd FileType fortran set expandtab shiftwidth=2 tabstop=2
autocmd FileType python set noexpandtab shiftwidth=4 tabstop=4 foldignore=
"autocmd FileType python set expandtab shiftwidth=4 tabstop=4 foldignore=
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
"set statusline+=%{FugitiveStatusline()}
set statusline+=\[%f\]
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\[%{&fileformat}\]
set statusline+=\[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\[%B\]
set statusline+=\ \[%v·%l/%L\]
set statusline+=\ 


" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"  " Always show the signcolumn, otherwise it would shift the text each time
"  " diagnostics appear/become resolved.
"  if has("patch-8.1.1564")
"    " Recently vim can merge signcolumn and number column into one
"    set signcolumn=number
"  else
"    set signcolumn=yes
"  endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
