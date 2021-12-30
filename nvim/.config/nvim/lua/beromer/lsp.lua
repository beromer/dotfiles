
local lspconfig = require('lspconfig')

lspconfig.pyright.setup{}
lspconfig.texlab.setup{}
-- lspconfig.lua.setup{}
lspconfig.sumneko_lua.setup{
	cmd = { 'lua-language-server' , "-E", "/Users/beromer/.local/share/lua-language-server/main.lua"},
	settings = {
		Lua = {
			diagnostics = {
                -- recognize certain globals
				globals = { 'vim', 'fiesta'}
			},
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
		}
	},
}

-- Setup nvim-cmp.
local cmp = require('cmp')
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
        end, { "i", "s", }),
        ["<Tab>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                -- if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
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
                -- if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
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
