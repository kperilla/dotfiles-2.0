-- For lsp-zero
-- local lsp = require('lsp-zero')
--
-- lsp.preset('recommended')
-- lsp.setup()

-- from https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(event)
        -- Create your keybindings here...
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        -- Replace these with whatever servers you want to install
        -- 'rust_analyzer',
        -- 'tsserver',
        -- 'csharp_ls',
        -- 'omnisharp',
        -- 'pyright',
        -- 'lua_ls',
        --'gopls',
        -- 'dockerls',
    }
})

local lspconfig = require('lspconfig')
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lspconfig.lua_ls.setup {
--     on_init = function(client)
--         local path = client.workspace_folders[1].name
--         if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
--             client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
--                 Lua = {
--                     runtime = {
--                         -- Tell the language server which version of Lua you're using
--                         -- (most likely LuaJIT in the case of Neovim)
--                         version = 'LuaJIT'
--                     },
--                     -- Make the server aware of Neovim runtime files
--                     workspace = {
--                         checkThirdParty = false,
--                         library = {
--                             vim.env.VIMRUNTIME
--                             -- "${3rd}/luv/library"
--                             -- "${3rd}/busted/library",
--                         }
--                         -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
--                         -- library = vim.api.nvim_get_runtime_file("", true)
--                     }
--                 }
--             })
--
--             client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--         end
--         return true
--     end
-- }

lspconfig.pyright.setup {}

require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            --capabilities = lsp_capabilities,
        })
    end,
})
