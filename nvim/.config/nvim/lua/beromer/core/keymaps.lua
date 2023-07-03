-- local function mapd(mode,cmd,exec,opts)
--     opts = opts or {noremap=true, silent=false}
--     vim.api.nvim_set_keymap(mode,cmd,exec,opts)
-- end

local kmap = vim.keymap.set
vim.keymap.set("n","<Space>","<Nop>",{})
vim.g.mapleader=" "
vim.keymap.set("i","kj","<Esc>", {noremap=true})
vim.keymap.set("i","jk","<Esc>", {noremap=true})

-- basic emacs combos for insert mode
vim.keymap.set("i","<C-a>","<Esc>I")
vim.keymap.set("i","<C-e>","<Esc>A")
vim.keymap.set("i","<M-f>","<Esc><Space>wi", {noremap=true})
vim.keymap.set("i","<M-b>","<Esc>bi", {noremap=true})
vim.keymap.set("i","<M-d>","<Esc><Space>cw", {noremap=true})
vim.keymap.set("i","<M-BS>","<C-W>", {noremap=true})
-- vim.keymap.set("n","kj","<Esc>", {noremap=true})

kmap("n", "<leader><leader>", ":")

kmap('i', '{<CR>',   '{<CR>}<ESC>O')
kmap('n', 'Q',       '<Nop>')
kmap('n', 'q:',      '<Nop>')

kmap('n','x','"_x')

-- lsp
kmap('n', '<leader>gD',      ':lua vim.lsp.buf.declaration()<CR>')
kmap('n', '<leader>gd',      ':lua vim.lsp.buf.definition()<CR>')
kmap('n', '<leader>gi',      ':lua vim.lsp.buf.implementation()<CR>')
kmap('n', '<leader>ga',      ':lua vim.lsp.buf.code_action()<CR>')
kmap('n', '<leader>en',      ':lua vim.diagnostic.goto_next()<CR>')
kmap('n', '<leader>ep',      ':lua vim.diagnostic.goto_prev()<CR>')
kmap('n', '<leader>eu',      ':lua vim.lsp.buf.references()<CR>')
kmap('n', '<leader>er',      ':lua vim.lsp.buf.rename()<CR>')
kmap('n', '<leader>es',      ':lua vim.lsp.buf.signature_help()<CR>')
kmap('n', '<leader>ee',      ':lua vim.diagnostic.open_float()<CR>')
kmap('n', 'K',      ':lua vim.lsp.buf.hover()<CR>')

kmap('n', '<leader>et',     ':NvimTreeToggle<CR>')

-- center selected search term
kmap('n', 'n',       'nzzzv')
kmap('n', 'N',       'Nzzzv')

-- navigation
-- kmap('n', '<Space>', '<C-f>')
kmap('n', '<Tab>',   ':bn<CR>')
kmap('n', '<S-Tab>', ':bp<CR>')
kmap('',  '<C-h>',   '<C-w>h')
kmap('',  '<C-j>',   '<C-w>j')
kmap('',  '<C-k>',   '<C-w>k')
kmap('',  '<C-l>',   '<C-w>l')

-- mapd('n', '<Leader>v', ':e $MYVIMRC<CR>')
-- mapd('n', '<Leader>r', ':so $MYVIMRC<CR>')
kmap('n', '<Leader>r', ':so $MYVIMRC<CR>')
-- kmap('n', '<Leader>q', ':bd<CR>')
kmap('n', '<Leader>;', 'A;<ESC>')
kmap('n', '<Leader>m', ':make<CR>')
-- kmap('n', '<Leader>w', ':w<CR>')

-- surroung visual text with ' or "
-- mapd('v', "<Leader>'", "s''<esc>P")
-- mapd('v', '<Leader>"', 's""<esc>P')

-- ultisnips
kmap('n','<Leader>ue',':UltiSnipsEdit<CR>')

-- quit
kmap('n','<leader>qq',':qa<CR>')
kmap('n','<leader>wq',':wq<CR>')

-- files
kmap('n','<Leader>pf',':Telescope find_files<CR>')
kmap('n','<Leader>ff',':lua search_home_files()<CR>')
kmap('n','<Leader>fs',':w<CR>')
kmap('n','<Leader>fr',':e!<CR>')

-- buffers
kmap('n','<Leader>bo',':Telescope buffers<CR>')
kmap('n','<Leader>bd',':bdelete<CR>')
kmap('n','<Leader>bn',':bn<CR>')
kmap('n','<Leader>bp',':bp<CR>')

-- projects
kmap('n','<Leader>pg',':Telescope live_grep<CR>')
kmap('n','<Leader>v',':lua search_dotfiles()<CR>')

-- indent blankline
kmap('n','<Leader>il',':IndentBlanklineToggle<CR>')
kmap('n','<Leader>ir',':IndentBlanklineRefresh<CR>')

-- undo highlight
kmap('n','<leader>no',':noh<CR>')

-- fugitive and gitgutter
kmap('n','<Leader>gg',':Git<CR>')
kmap('n','<Leader>gl',':Gclog<CR>')
kmap('n','<Leader>gP',':G push<Space>')
kmap('n','<Leader>gp',':G pull<Space>')
kmap('n','<Leader>hs',':GitGutterStageHunk<CR>"')
kmap('n','<Leader>hu',':GitGutterUndoHunk<CR>')
kmap('n','<Leader>hn',':GitGutterNextHunk<CR>')
kmap('n','<Leader>hp',':GitGutterPrevHunk<CR>')

-- quick fix list
kmap('n','<Leader>co',':copen<CR>')
kmap('n','<Leader>cq',':ccl<CR>')
kmap('n','<Leader>cn',':cnext<CR>')
kmap('n','<Leader>cp',':cprev<CR>')

-- location list
kmap('n','<Leader>lo',':lopen<CR>')
kmap('n','<Leader>lq',':lcl<CR>')
kmap('n','<Leader>ln',':lnext<CR>')
kmap('n','<Leader>lp',':lprev<CR>')

-- vimtex
kmap('n','<Leader>to',':VimtexTocToggle<CR>')
kmap('n','<Leader>tc',':VimtexCountWords<CR>')

-- in visual mode, swap line up or down <- interferes with multiple line joine
-- mapd('v','J',":m '>+1<CR>gv=gv")
-- mapd('v','K',":m '<-2<CR>gv=gv")

-- add numbered movements to jumplist
vim.cmd([[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k']])
vim.cmd([[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j']])
