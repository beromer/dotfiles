require('packer').startup(function()
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
    use 'altercation/vim-colors-solarized'
    use 'hoob3rt/lualine.nvim'
end)

require("indent_blankline").setup {
    char = "|",
    --char = "┊",
    show_trailing_blankline_indent = false,
    --show_first_indent_level = false,
    buftype_exclude = {"terminal"}
}
require('nvim_comment').setup()
require('nvim-autopairs').setup{}
require'lualine'.setup{
    options={icons_enabled=false, theme='solarized'},
    sections={lualine_b={'branch','diff'}}
}
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = {"latex"},
    },
}
require "nvim-treesitter.configs".setup {
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}
require'lspconfig'.pyright.setup{}
require'lspconfig'.texlab.setup{}
-- Setup nvim-cmp.
local cmp = require("cmp")
local has_any_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local press = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local cmp = require'cmp'

cmp.setup( {
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
                    return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
                end

                cmp.select_next_item()
            elseif has_any_words_before() then
                press("<Space>")
            else
                fallback()
            end
        end, {
        "i",
        "s",
    }),
    ["<Tab>"] = cmp.mapping({
        i = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                --vim.api.nvim_feedkeys(t("<C-t>"), 'm', true)
            else
                fallback()
            end
        end,
        s = function(fallback)
            if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
            else
                fallback()
            end
        end
    }),
    ["<S-Tab>"] = cmp.mapping({
        i = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
            else
                fallback()
            end
        end,
        s = function(fallback)
            if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
            else
                fallback()
            end
        end
    }),
    ['<C-n>'] = cmp.mapping({
        i = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end
    }),
    ['<C-p>'] = cmp.mapping({
        i = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end
    }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i'}),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
},
sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'spell' },
}
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.clangd.setup {
    capabilities = capabilities
}
vim.o.cursorline = true
vim.o.compatible = false
vim.o.title = true
vim.o.exrc = true
vim.o.secure = true
vim.o.autowrite = true
vim.o.showmode = false
vim.o.showcmd = true
vim.o.rnu = true
vim.o.wildmenu = true
vim.o.number = true
vim.o.wrap = false
vim.o.hidden = true
vim.o.autoread = true
vim.o.startofline = false
vim.o.confirm = true
vim.o.ttyfast = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.shiftround = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.autoindent = true
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
vim.o.encoding='utf-8'

vim.o.fillchars = 'fold:≣,vert:│,diff:╳'
vim.o.foldlevelstart=0
-- vim.o.foldmethod='indent'
function _G.custom_fold_text()
    return string.format("[%d]",vim.v.foldend-vim.v.foldstart+1)
end
vim.o.foldtext = 'v:lua.custom_fold_text()'
-- vim.o.foldmethod='indent'
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr'
vim.cmd [[
augroup set-commentstring-ag
autocmd!
autocmd BufEnter *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
" when you've changed the name of a file opened in a buffer, the file type may have changed
autocmd BufFilePost *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
augroup END
]]
vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
augroup END
]]

vim.cmd[[colorscheme solarized]]
vim.o.background='dark'

vim.o.makeprg='ninja -C ../build'

vim.o.timeoutlen=750
vim.o.ttimeoutlen=0
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.backspace='indent,eol,start'
vim.o.so=3
vim.o.mouse='a'
vim.o.laststatus=2
vim.o.listchars=vim.o.listchars..",extends:,precedes:,trail:█"
vim.o.shortmess='IcF'
vim.o.clipboard='unnamed'
vim.o.backupcopy='yes'
vim.o.titlestring="%t %M"
vim.cmd[[autocmd vimenter * wincmd l]]
vim.cmd[[
let &t_SI="\<Esc>[5 q"
if v:version > 704
let &t_SR="\<Esc>[3 q"
endif
let &t_EI="\<Esc>[2 q"
]]
vim.g.fortran_free_source=1
vim.g.fortran_do_enddo=1
vim.cmd[[
syntax on
filetype plugin indent on
]]
vim.g.netrw_altv=1
vim.g.netrw_browse_split=4
vim.g.netrw_liststyle=3
vim.g.netrw_fastbrowse=0
vim.g.netrw_sort_by='exten'
vim.o.viewoptions='cursor,folds'
vim.cmd[[
autocmd BufWinLeave * silent! mkview | filetype detect
autocmd BufWinEnter * silent! loadview | filetype detect
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType cpp setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType fortran setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 list
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 nofoldenable
autocmd FileType zsh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldignore=
autocmd FileType git setlocal expandtab shiftwidth=4 tabstop=4 foldignore= spell complete+=kspell
autocmd FileType mail setlocal textwidth=0 nofoldenable spell complete+=kspell
autocmd FileType text setlocal spell wrap linebreak tw=0 showbreak=… complete+=kspell
autocmd FileType tex setlocal textwidth=80 expandtab shiftwidth=4 tabstop=4 spell
autocmd FileType rst setlocal textwidth=80 expandtab shiftwidth=4 tabstop=4 foldignore= spell complete+=kspell
]]
vim.highlight.create('SignColumn',{ctermbg='NONE'},false)
vim.highlight.create('Folded',{cterm='bold',ctermbg='NONE'},false)


vim.g.mapleader=","
vim.api.nvim_set_keymap('','Y','y$', {noremap=false,silent=false})
vim.api.nvim_set_keymap('i','{<CR>','{<CR>}<ESC>O',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','Q','<nop>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','q:','<nop>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('v',"<Leader>'","s''<esc>P",{noremap=true,silent=true})
vim.api.nvim_set_keymap('v','<Leader>"','s""<esc>P',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','gD',':lua vim.lsp.buf.declaration()<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','gd',':lua vim.lsp.buf.definition()<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('','<C-h>','<C-w>h',{noremap=true,silent=true})
vim.api.nvim_set_keymap('','<C-j>','<C-w>j',{noremap=true,silent=true})
vim.api.nvim_set_keymap('','<C-k>','<C-w>k',{noremap=true,silent=true})
vim.api.nvim_set_keymap('','<C-l>','<C-w>l',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','n','nzzzv',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','N','Nzzzv',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Space>','<C-f>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Tab>',':bn<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<S-Tab>',':bp<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>v',':e $MYVIMRC<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>r',':so $MYVIMRC<CR>',{noremap=true,silent=false})
vim.api.nvim_set_keymap('n','<Leader>q',':bd<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>;','A;<ESC>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>w',':w<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>m',':make<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>ue',':UltiSnipsEdit<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>o',':Telescope find_files<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>b',':Telescope buffers<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>f',':Telescope live_grep<CR>',{noremap=true,silent=true})

vim.api.nvim_set_keymap('n','<Leader>gg',':Git<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>gl',':Gclog<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>pu',':G push<Space>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>gs',':GitGutterStageHunk<CR>"',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>gu',':GitGutterUndoHunk<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>gn',':GitGutterNextHunk<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>gp',':GitGutterPrevHunk<CR>',{noremap=true,silent=true})

vim.api.nvim_set_keymap('n','<Leader>co',':copen<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>cq',':ccl<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>cn',':cnext<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>cp',':cprev<CR>',{noremap=true,silent=true})

vim.api.nvim_set_keymap('n','<Leader>lo',':lopen<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>lq',':lcl<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>ln',':lnext<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>lp',':lprev<CR>',{noremap=true,silent=true})

vim.api.nvim_set_keymap('n','<Leader>tc',':VimtexCountWords<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<Leader>to',':VimtexTocToggle<CR>',{noremap=true,silent=true})
