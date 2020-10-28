set nocompatible

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'maxboisvert/vim-simple-complete'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

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

autocmd vimenter * wincmd l

" AUTOPAIRS SETUP "
let g:AutoPairsFlyMode = 1

" FZF SETUP "
let g:fzf_buffers_jump = 1
"let g:fzf_layout = { 'window': '10new' }

set splitbelow

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
set listchars=tab:▸\ ,eol:¬
set hidden
set autoread
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

" SEARCHING "
set incsearch
set hlsearch
set ignorecase
set smartcase

" SAVE BUFFER POSITION "
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"" AUTOMATIC BRACKET MATCHING "
"inoremap ( ()<esc>i
"inoremap [ []<esc>i
"inoremap { {}<esc>i
"inoremap {<CR> {<CR>}<esc>O
"inoremap ' ''<esc>i
"inoremap " ""<esc>i

""" POWERLINE "
""set rtp+=/usr/share/vim/addons/plugin/
""silent! python3 from powerline.vim import setup as powerline_setup
""silent! python3 powerline_setup()
""silent! python3 del powerline_setup

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

au WinLeave * silent! let &colorcolumn=join(range(1,256),',')
au winLeave * silent! setlocal winhighlight=LineNr:nrinactive
au winLeave * silent! setlocal winhighlight=Normal:nrinactive
au WinEnter * silent! set cc=
au winEnter * silent! setlocal winhighlight=LineNr:nractive
au winEnter * silent! setlocal winhighlight=Normal:nractive

au FocusLost * silent! let &colorcolumn=join(range(1,256),',')
au FocusLost * silent! setlocal winhighlight=LineNr:nrinactive
au FocusLost * silent! setlocal winhighlight=Normal:nrinactive
au FocusGained * silent! set cc=
au FocusGained * silent! setlocal winhighlight=LineNr:nractive
au FocusGained * silent! setlocal winhighlight=Normal:nractive

" MAPS "
"map <C-h> <C-W>h
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-l> <C-W>l
map Y y$
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" LEADER MAPS "
let mapleader=","
"save/quit"
""nnoremap <Leader>qa :qa<CR>
""nnoremap <Leader>qq :q!<CR>
""nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>ww :w<CR>
nnoremap <Leader>wq :wqa<CR>
"buffers"
nnoremap <Leader>bl :ls<CR>:b<Space>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bb <C-^>
"windows"
nnoremap <Leader>wl :Vex!<CR>
nnoremap <Leader>wh :Vex<CR>
nnoremap <Leader>wj :Hex<CR>
nnoremap <Leader>wk :Hex!<CR>
nnoremap <Leader>wt :Tex<CR>
nnoremap <Leader>wo :on<CR>
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
nnoremap <silent> <leader>m :make!<CR>:cw 5<CR>
nnoremap <leader>en :cn<CR>
nnoremap <leader>ep :cp<CR>
nnoremap <leader>ef :cr<CR>
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
autocmd FileType zsh set expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldignore=
autocmd FileType git set expandtab shiftwidth=4 tabstop=4 foldignore=

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'['.l:branchname.']':''
endfunction

set statusline=
set statusline+=%#CursorColumn#
"set statusline+=%{StatuslineGit()}
set statusline+=%{FugitiveStatusline()}
set statusline+=\[%f\]
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\[%{&fileformat}\]
set statusline+=\[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\[%B\]
set statusline+=\ \[%v·%l/%L\]
set statusline+=\ 
