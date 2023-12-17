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
  'rebelot/kanagawa.nvim',
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  'tpope/vim-fugitive',
  --'rstacruz/vim-closer';
--  {'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { {'nvim-lua/plenary.nvim'} } };
--  {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}};
--  {
--    'nvim-treesitter/nvim-treesitter',
--    run = function()
--      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
--      ts_update()
--    end,
--  };
}
local opts = {}
require("lazy").setup(plugins, opts)

