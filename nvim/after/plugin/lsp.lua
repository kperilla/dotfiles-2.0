-- For lsp-zero
-- local lsp = require('lsp-zero')
--
-- lsp.preset('recommended')
-- lsp.setup()

-- from https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- Create your keybindings here...
    end
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        -- Replace these with whatever servers you want to install
        'rust_analyzer',
        'tsserver',
        --'csharp_ls',
        'pyright',
        'lua_ls',
        --'gopls',
        'dockerls',
    }
})

local lspconfig = require('lspconfig')
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            --capabilities = lsp_capabilities,
        })
    end,
})

