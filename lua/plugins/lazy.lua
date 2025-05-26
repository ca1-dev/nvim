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
    -- misc
    { 'lukas-reineke/indent-blankline.nvim', version = '3.x.x' },
    { 'lewis6991/gitsigns.nvim',             version = '1.x.x' },
    { 'preservim/nerdcommenter',             version = '2.x.x' },
    {
        'nvim-lualine/lualine.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    { 'windwp/nvim-autopairs', version = '*' },
    { 'mbbill/undotree',       version = '*' },

    -- themes
    { 'folke/tokyonight.nvim', version = '4.x.x', },
    { 'catppuccin/nvim',       version = '1.x.x', },

    -- nvim-tree
    {
        'nvim-tree/nvim-tree.lua',
        version = '1.x.x',
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
        version = '0.9.x',
        build = ':TSUpdate',
    },
    { 'nvim-treesitter/nvim-treesitter-context', version = '*' },

    -- lsp,
    { 'mason-org/mason.nvim',                    version = '2.x.x', },
    { 'neovim/nvim-lspconfig',                   version = '2.x.x', },
    { 'mason-org/mason-lspconfig.nvim',          version = '2.x.x', },
    { 'nvimtools/none-ls.nvim',                  version = '*' },
    { 'jay-babu/mason-null-ls.nvim',             version = '2.x.x', },

    -- autocomplete
    {
        'saghen/blink.cmp',
        version = '1.x.x',
        dependencies = 'rafamadriz/friendly-snippets',
    },
}
