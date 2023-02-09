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
    use 'windwp/nvim-autopairs'
    use 'sirver/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'beromer/solarized.nvim'
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'christoomey/vim-tmux-navigator'
    use 'tpope/vim-surround'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    if packer_bootstrap then
        require('packer').sync()
    end
end)

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "sumneko_lua", "clangd", "pyright", "bashls"},
}

require('beromer.plugins.lsp')
require('beromer.plugins.treesitter')
require('beromer.plugins.nvimtree')

require("treesitter-context").setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    zindex = 20, -- The Z-index of the context window
    mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    -- separator = '═',
    -- separator = '─',
    -- separator = '-',
    separator = nil,
}

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
        search_dirs = {vim.fn.stdpath('config')},
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
