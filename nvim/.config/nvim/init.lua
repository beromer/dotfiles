local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'terrortylor/nvim-comment'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'lervag/vimtex'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use { 'nvim-treesitter/playground', run = ':TSUpdate'}
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'f3fora/cmp-spell'
    use 'ggandor/lightspeed.nvim'
    use 'windwp/nvim-autopairs'
    use 'sirver/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'beromer/solarized.nvim'
    use 'hoob3rt/lualine.nvim'
    if packer_bootstrap then
        require('packer').sync()
    end
end)

local color_scheme = require('solarized')
local stheme = os.getenv("ITERM_PROFILE")=="Light" and "light" or "dark"
color_scheme.load{
    theme = stheme,
    italic_comments = true,
    italic_strings = true
}

require('telescope').setup{
    defaults = {
        file_ignore_patterns = {".git"},
        path_display = {"truncate"},
    }
}

_G.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = '~',
        search_dirs = {'~/.local/share/nvim/site/pack/packer/','~/.config/','~/dotfiles'},
        hidden = true,
        follow = true,
    })
end

require("indent_blankline").setup {
    char = "|",
    --char = "┊",
    show_trailing_blankline_indent = false,
    --show_first_indent_level = false,
    buftype_exclude = {"terminal"},
    filetype = {"python"}
}

require('nvim_comment').setup()

require('nvim-autopairs').setup{}

require'lualine'.setup{
    options={icons_enabled=true, theme='solarized'},
    sections={
        -- lualine_b = {'branch'},--,{'diff',colored = false}}
        lualine_b = {'branch'},--,{'diff',colored = false}}
        lualine_z = {},
        lualine_x = {'filetype'},
        lualine_y = {'location'},
    },
    inactive_sections = {
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {}
    },
    extensions = {'fugitive'}
}


require('beromer/lsp')
require('beromer/treesitter')

vim.o.cursorline = true
vim.o.compatible = false
vim.o.title = true
vim.o.exrc = true
vim.o.secure = true
vim.o.autowrite = true
vim.o.showmode = false
vim.o.showcmd = true
vim.o.rnu = true
vim.o.number = true
vim.o.wrap = false
vim.o.confirm = true
vim.o.ttyfast = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.shiftround = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.completeopt='menu,menuone,noselect'
vim.g.vimtex_view_method='zathura'
vim.o.conceallevel = 0

vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0
vim.g.UltiSnipsEditSplit="horizontal"

vim.o.fillchars = 'fold:≣,vert:│,diff:╳'
vim.o.foldlevelstart=0
function _G.custom_fold_text()
    return string.format("[%d]",vim.v.foldend-vim.v.foldstart+1)
end
vim.o.foldtext = 'v:lua.custom_fold_text()'
vim.o.foldmethod='indent'
-- vim.o.foldmethod='expr'
-- vim.o.foldexpr='nvim_treesitter#foldexpr'

-- use // vor c and cpp comments instead of /* */
vim.cmd [[
augroup set-commentstring-ag
autocmd!
autocmd BufEnter *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
autocmd BufFilePost *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
augroup END
]]
vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
augroup END
]]

vim.o.makeprg='ninja -C ../build'

vim.o.timeoutlen=750
vim.o.ttimeoutlen=0
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.so=3
vim.o.mouse='a'
vim.o.listchars=vim.o.listchars..",extends:,precedes:,trail:█"
vim.o.shortmess='IcF'
vim.o.clipboard='unnamed'
vim.o.backupcopy='yes'
vim.o.titlestring="%t %M"
vim.cmd[[autocmd vimenter * wincmd l]]
-- vim.cmd[[
-- let &t_SI="\<Esc>[5 q"
-- if v:version > 704
-- let &t_SR="\<Esc>[3 q"
-- endif
-- let &t_EI="\<Esc>[2 q"
-- ]]
vim.g.fortran_free_source=1
vim.g.fortran_do_enddo=1
vim.g.syntax='on'
vim.g.netrw_altv=1
vim.g.netrw_browse_split=4
vim.g.netrw_liststyle=3
vim.g.netrw_fastbrowse=0
vim.g.netrw_sort_by='exten'
vim.o.viewoptions='cursor,folds'
local function auft(name,opts)
    vim.cmd('autocmd FileType '..name..' setlocal '..opts)
end
vim.cmd('autocmd BufWinLeave * silent! mkview | filetype detect')
vim.cmd('autocmd BufWinEnter * silent! loadview | filetype detect')
auft('fortran','et sw=2 ts=2')
auft('python', 'et sw=4 ts=4 list')
auft('make','noet sw=8 sts=0')
auft('cpp', 'et sw=2 ts=2')
auft('vim', 'et sw=2 ts=2 sts=2 nofen')
auft('zsh', 'et sw=2 ts=2 sts=2 fdi=')
auft('git', 'et sw=4 ts=4 fdi= spell cpt+=kspell')
auft('mail','tw=0 nofen spell cpt+=kspell')
auft('text','spell wrap lbr tw=0 sbr=… cpt+=kspell')
auft('tex', 'tw=80 et sw=4 ts=4 spell')
auft('rst',' tw=80 et sw=4 ts=4 fdi= spell cpt+=kspell')

vim.highlight.create('SignColumn',{ctermbg='NONE'},false)
vim.highlight.create('Folded',{cterm='bold',ctermbg='NONE'},false)

local function mapd(mode,cmd,exec,opts)
    opts = opts or {noremap=true, silent=true}
    vim.api.nvim_set_keymap(mode,cmd,exec,opts)
end
vim.g.mapleader=","
mapd('i', '{<CR>',   '{<CR>}<ESC>O')
mapd('n', 'Q',       '<nop>')
mapd('n', 'q:',      '<nop>')
mapd('n', 'gD',      ':lua vim.lsp.buf.declaration()<CR>')
mapd('n', 'gd',      ':lua vim.lsp.buf.definition()<CR>')

-- center selected search term
mapd('n', 'n',       'nzzzv')
mapd('n', 'N',       'Nzzzv')

-- navigation
mapd('n', '<Space>', '<C-f>')
mapd('n', '<Tab>',   ':bn<CR>')
mapd('n', '<S-Tab>', ':bp<CR>')
mapd('',  '<C-h>',   '<C-w>h')
mapd('',  '<C-j>',   '<C-w>j')
mapd('',  '<C-k>',   '<C-w>k')
mapd('',  '<C-l>',   '<C-w>l')

-- mapd('n', '<Leader>v', ':e $MYVIMRC<CR>')
-- mapd('n', '<Leader>r', ':so $MYVIMRC<CR>')
mapd('n', '<Leader>r', ':so $MYVIMRC<CR>')
mapd('n', '<Leader>q', ':bd<CR>')
mapd('n', '<Leader>;', 'A;<ESC>')
mapd('n', '<Leader>m', ':make<CR>')
mapd('n', '<Leader>w', ':w<CR>')

-- surroung visual text with ' or "
mapd('v', "<Leader>'", "s''<esc>P")
mapd('v', '<Leader>"', 's""<esc>P')

-- ultisnips
mapd('n','<Leader>ue',':UltiSnipsEdit<CR>')

-- tscope
mapd('n','<Leader>o',':Telescope find_files<CR>')
mapd('n','<Leader>b',':Telescope buffers<CR>')
mapd('n','<Leader>f',':Telescope live_grep<CR>')
mapd('n','<Leader>v',':lua search_dotfiles()<CR>')

-- indent blankline
mapd('n','<Leader>il',':IndentBlanklineToggle<CR>')
mapd('n','<Leader>ir',':IndentBlanklineRefresh<CR>')

-- fugitive and gitgutter
mapd('n','<Leader>gg',':Git<CR>')
mapd('n','<Leader>gl',':Gclog<CR>')
mapd('n','<Leader>pu',':G push<Space>')
mapd('n','<Leader>gs',':GitGutterStageHunk<CR>"')
mapd('n','<Leader>gu',':GitGutterUndoHunk<CR>')
mapd('n','<Leader>gn',':GitGutterNextHunk<CR>')
mapd('n','<Leader>gp',':GitGutterPrevHunk<CR>')

-- quick fix list
mapd('n','<Leader>co',':copen<CR>')
mapd('n','<Leader>cq',':ccl<CR>')
mapd('n','<Leader>cn',':cnext<CR>')
mapd('n','<Leader>cp',':cprev<CR>')

-- local list
mapd('n','<Leader>lo',':lopen<CR>')
mapd('n','<Leader>lq',':lcl<CR>')
mapd('n','<Leader>ln',':lnext<CR>')
mapd('n','<Leader>lp',':lprev<CR>')

-- vimtex
mapd('n','<Leader>to',':VimtexTocToggle<CR>')
mapd('n','<Leader>tc',':VimtexCountWords<CR>')

-- in visual mode, swap line up or down
mapd('v','J',":m '>+1<CR>gv=gv")
mapd('v','K',":m '<-2<CR>gv=gv")

-- add numbered movements to jumplist
vim.cmd([[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k']])
vim.cmd([[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j']])
