-- Install packer
local ensure_packer = function ()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Initialize packer
require('packer').init({
    compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'solid' })
        end,
    },
})

-- Install plugins
local use = require('packer').use

use('wbthomason/packer.nvim') -- Let packer manage itself

-- Colortheme - Dracula
use({
    'Mofiqul/dracula.nvim',
    config = function()
        vim.cmd('colorscheme dracula')
    end,
})

-- nvim-tree
use ({
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons', -- for file icons, optional
    config = function()
        require('codyg.plugins.nvim-tree')
    end,
})

use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end,
})

use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'dracula.nvim',
    config = function()
        require('codyg.plugins.bufferline')
    end,
})

use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('codyg.plugins.lualine')
    end,
})

use({
    'nvim-telescope/telescope.nvim',
    requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
        require('codyg.plugins.telescope')
    end,
})

use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
        require('codyg.plugins.treesitter')
    end,
})

use({
    'neovim/nvim-lspconfig',
    requires = {
        'b0o/schemastore.nvim',
        'folke/lsp-colors.nvim',
    },
    config = function()
        require('codyg.plugins.lspconfig')
    end,
})

use({
    'L3MON4D3/LuaSnip',
    config = function()
        require('codyg.plugins.luasnip')
    end,
})

use "rafamadriz/friendly-snippets"

use({
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'jessarcher/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    require('codyg.plugins.cmp')
  end,
})

-- Automatically install plugins on first run
if packer_bootstrap then
    require('packer').sync()
end

-- Automatically regenerate compiled loader file on save
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile>
    augroup end
]])




