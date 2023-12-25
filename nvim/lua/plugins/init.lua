local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Color schemes
    'rebelot/kanagawa.nvim',
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000
    },
    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- LSP
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    'neovim/nvim-lspconfig',
    -- Install management
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Completion/snippets
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'saadparwaiz1/cmp_luasnip',
    'numToStr/Comment.nvim',
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    -- QoL
    'tpope/vim-fugitive',
    'rstacruz/vim-closer',
}
local opts = {}
require("lazy").setup(plugins, opts)
