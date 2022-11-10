vim.o.laststatus = 3
vim.o.winbar='%=%m %t'
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
vim.o.foldlevelstart=100
function _G.custom_fold_text()
    return string.format("[%d]",vim.v.foldend-vim.v.foldstart+1)
end
vim.o.foldtext = 'v:lua.custom_fold_text()'
vim.o.foldmethod='indent'
-- vim.o.foldmethod='expr'
-- vim.o.foldexpr='nvim_treesitter#foldexpr'

vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
augroup END
]]

vim.o.makeprg='ninja -C ../build'

vim.o.updatetime=100
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
-- vim.cmd[[autocmd User TelescopePreviewerLoaded setlocal foldlevel=100]]
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

-- vim.highlight.create('SignColumn',{ctermbg='NONE'},false)
-- vim.highlight.create('Folded',{cterm='bold',ctermbg='NONE'},false)
-- vim.api.nvim_set_hl(0,'SignColumn',{bg='NONE'})
-- vim.api.nvim_set_hl(0,'Folded',{bold=true,bg='NONE'})


-- use // vor c and cpp comments instead of /* */
vim.cmd [[
autocmd FileType cpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
]]
-- vim.cmd [[
-- autocmd BufEnter *.cpp,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
-- ]]
-- vim.cmd [[
-- autocmd BufFilePost *.cpp,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
-- ]]
-- vim.cmd [[
-- augroup set-commentstring-ag
-- autocmd!
-- autocmd BufEnter *.cpp,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
-- autocmd BufFilePost *.cpp,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
-- augroup END
-- ]]
