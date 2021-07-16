set nocompatible

call plug#begin()
  "Plug 'junegunn/fzf'
  "Plug 'junegunn/fzf.vim'
  "Plug 'bfrg/vim-cpp-modern'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'hrsh7th/nvim-compe'

"  Plug 'neovim/nvim-lspconfig'
"  Plug 'glepnir/lspsaga.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  "Plug 'JuliaEditorSupport/julia-vim'
  Plug 'tpope/vim-fugitive'
"  Plug 'morhetz/gruvbox'
  Plug 'altercation/vim-colors-solarized'
  Plug 'vimwiki/vimwiki'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'airblade/vim-gitgutter'
call plug#end()

lua << EOF
require'lualine'.setup{
options={icons_enabled=false, theme='solarized'},
sections={lualine_b={'branch','diff'}}
}
EOF

"lua << EOF
"local saga=require 'lspsaga'
"saga.init_lsp_saga()
"EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
let s:fsym='↘'
let s:lsym='≣'
let s:small_l='ℓ'
function! Myfoldtext()
  let l:lines='[' . (v:foldend - v:foldstart + 1) . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:fsym, 'g')
  "return s:lsym . l:lines . l:dashes . ': ' . l:first . ' '
  return l:lines
endfunction
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set fillchars+=fold:≣
set foldlevelstart=0
set foldtext=Myfoldtext()
set foldmethod=indent

"autocmd vimenter * ++nested colorscheme gruvbox
"let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_undercurl=1
"colorscheme gruvbox
syntax enable
set background=dark
colorscheme solarized

let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_list = [{'path': '~/Dropbox/notes/', 'path_html': '~/Dropbox/notes/html'}]
autocmd FileType vimwiki autocmd BufWritePost <buffer> silent VimwikiAll2HTML


set makeprg=ninja\ -C\ ../build
"set cursorline

" [BRACKETS] '
"vnoremap i] "sdi[]<esc>P
"vnoremap i} "sdi{}<esc>P
"vnoremap i) "sdi()<esc>P
"vnoremap i" "sdi""<esc>P
"vnoremap i' "sdi''<esc>P
inoremap{<CR> {<CR>}<ESC>O

" [HIGHLIGHT YANK] "
if has('nvim')
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
  augroup END
endif

"" AUTOCOMPLETE "
set completeopt=menuone,noselect
let g:compe={}
let g:compe.enabled=v:true
let g:compe.autocomplete=v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

"set path+=**
"set completeopt+=longest,menuone,noinsert
"inoremap <expr> <Tab> TabComplete()
"fun! TabComplete()
"    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
"    "if pumvisible()
"        return "\<C-n>"
"    else
"        return "\<Tab>"
"    endif
"endfun
"inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
"autocmd InsertCharPre * call AutoComplete()
"fun! AutoComplete()
"    if v:char =~ '\K'
"        \ && getline('.')[col('.') - 4] !~ '\K'
"        \ && getline('.')[col('.') - 3] =~ '\K'
"        \ && getline('.')[col('.') - 2] =~ '\K' " last char
"        \ && getline('.')[col('.') - 1] !~ '\K'
"
"        call feedkeys("\<C-n>", 'n')
"    end
"endfun

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
set title
set titlestring=%t\ %M
set exrc
set secure
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
set clipboard=unnamed
set backupcopy=yes

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
"let s:fsym='↘'
"let s:lsym='≣'
"let s:small_l='ℓ'
"function! Myfoldtext()
"  let l:lines='[' . (v:foldend - v:foldstart + 1) . ']'
"  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
"  let l:dashes=substitute(v:folddashes, '-', s:fsym, 'g')
"  "return s:lsym . l:lines . l:dashes . ': ' . l:first . ' '
"  return l:lines
"endfunction
"if has('folding')
"  if has('windows')
"    "set fillchars+=fold:·
"    set fillchars+=fold:≣
"  endif
"  set foldmethod=indent
"  set foldlevelstart=0
"  set foldtext=Myfoldtext()
"endif
"set foldmethod=indent

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

"set fillchars+=stl:=

" DIFF STYLING"
set fillchars+=diff:\╳

" LEADER MAPS "
let mapleader=","
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>r :so ~/.config/nvim/init.vim<CR>

"nnoremap <Leader>o :Files<CR>
nnoremap <Leader>o :Telescope find_files<CR>
nnoremap <Leader>b :Telescope buffers<CR>
nnoremap <Leader>f :Telescope live_grep<CR>

nnoremap <Leader>ga :G add %:p<CR>
nnoremap <Leader>gc :G commit -v -q<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gp :G push<Space>
nnoremap <Leader>gd :GitGutterQuickFix<CR>:copen<CR>

nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cq :ccl<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>

"colorcolumn
"nnoremap <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? join(range(&tw+1,&tw+1000),',') : "")<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l



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
autocmd FileType rst setlocal textwidth=80 expandtab shiftwidth=4 tabstop=4 foldignore= spell complete+=kspell
autocmd BufNewFile,BufRead *.tmx set filetype=sh

" set statusline=
" set statusline+=%#Normal#
" set statusline+=\%y
" set statusline+=\[%f\]
" set statusline+=\[%{FugitiveHead()}\]
" set statusline+=%m
" set statusline+=%=
" set statusline+=\[%v·%l/%L\]

nnoremap <Space> <C-f>
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" ColorScheme
"highlight clear
"if exists("syntax_on")
"  syntax reset
"endif

"highlight Normal ctermbg=NONE
highlight Folded cterm=bold ctermbg=NONE
hi SignColumn ctermbg=NONE
"highlight CursorLineNr ctermbg=NONE

"highlight DiffAdd        ctermfg=0    ctermbg=2
"highlight DiffChange     ctermfg=0    ctermbg=3
"highlight DiffDelete     ctermfg=0    ctermbg=1
"highlight DiffText       ctermfg=0    ctermbg=11   cterm=bold
"highlight Visual         ctermfg=NONE ctermbg=NONE cterm=inverse
"highlight Search         ctermfg=0    ctermbg=11
"highlight SpecialKey     ctermfg=4
"highlight TermCursor     cterm=reverse
"highlight NonText        ctermfg=12
"highlight Directory      ctermfg=4
"highlight ErrorMsg       ctermfg=15 ctermbg=1
"highlight IncSearch      cterm=reverse
"highlight MoreMsg        ctermfg=2
"highlight ModeMsg        cterm=bold
"highlight CursorLineNr   ctermfg=3
"highlight Question       ctermfg=2
"highlight Title          ctermfg=5
"highlight WarningMsg     ctermfg=1
"highlight WildMenu       ctermfg=0 ctermbg=11
"highlight Conceal        ctermfg=7 ctermbg=7
"highlight SpellBad       ctermbg=NONE ctermfg=NONE cterm=undercurl
""highlight SpellBad       ctermbg=9
"highlight SpellRare      ctermbg=13
"highlight SpellLocal     ctermbg=14
"highlight PmenuSbar      ctermbg=8
"highlight PmenuThumb     ctermbg=0
"highlight TabLine        cterm=underline ctermfg=0 ctermbg=7
"highlight TabLineSel     cterm=bold
"highlight TabLineFill    cterm=reverse
"highlight CursorColumn   ctermbg=7
"highlight CursorLine     cterm=underline
"highlight MatchParen     ctermbg=14
"highlight Constant       ctermfg=5
"highlight Special        ctermfg=5
"highlight Identifier     cterm=NONE ctermfg=6
"highlight Statement      ctermfg=3
"highlight PreProc        ctermfg=5
"highlight Type           ctermfg=2
"highlight Underlined     cterm=underline ctermfg=5
"highlight Ignore         ctermfg=15
"highlight Error          ctermfg=15 ctermbg=9
"highlight Todo           ctermfg=0 ctermbg=11
"highlight LineNr         ctermfg=8
"highlight Comment        cterm=italic ctermfg=8
"highlight ColorColumn    ctermfg=7    ctermbg=8
"highlight Folded         ctermfg=7    ctermbg=0
"highlight FoldColumn     ctermfg=7    ctermbg=8
"highlight Pmenu          ctermfg=15   ctermbg=8
"highlight PmenuSel       ctermfg=8    ctermbg=15
"highlight SpellCap       ctermfg=7    ctermbg=8
"highlight StatusLine     ctermfg=15   ctermbg=8    cterm=bold
"highlight StatusLineNC   ctermfg=7    ctermbg=8    cterm=NONE
"highlight VertSplit      ctermfg=7    ctermbg=8    cterm=NONE
"highlight SignColumn                  ctermbg=8
