-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    -- library
    'nvim-lua/plenary.nvim',

    -- misc
    { 'lukas-reineke/indent-blankline.nvim', version = '*' },
    { 'lewis6991/gitsigns.nvim',             version = '*', },
    { 'preservim/nerdcommenter',             version = '*', },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    'windwp/nvim-autopairs',
    'mbbill/undotree',

    -- themes
    { 'folke/tokyonight.nvim', version = '*', },
    { 'catppuccin/nvim',       version = '*', },

    -- nvim-tree
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
    },

    -- telescope,
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        }
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        version = '*',
        build = ':TSUpdate',
    },
    'nvim-treesitter/nvim-treesitter-context',

    -- lsp,
    { 'williamboman/mason.nvim',           version = '*', },
    { 'neovim/nvim-lspconfig',             version = '*', },
    { 'williamboman/mason-lspconfig.nvim', version = '*', },
    'nvimtools/none-ls.nvim',
    { 'jay-babu/mason-null-ls.nvim', version = '*', },

    -- autocomplete
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = 'rafamadriz/friendly-snippets',
    },
}
