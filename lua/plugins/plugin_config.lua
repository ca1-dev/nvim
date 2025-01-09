local mappings = require('mappings')

require('ibl').setup {
    scope = { enabled = false, },
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {},
    auto_install = true,

    highlight = {
        enable = true,
        disable = { 'json', },
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = mappings.treesitter_keymaps,
    },
}

require('lualine').setup {
    options = {
        component_separators = { left = '|', right = '|', },
        section_separators = { left = '', right = '', },
        ignore_focus = { 'NvimTree', 'TelescopePrompt', },
        globalstatus = true,
    },
    sections = {
        lualine_b = { 'branch', 'b:gitsigns_status', 'diagnostics', },
        lualine_c = { '%f', },
        lualine_x = { 'encoding', 'fileformat', 'filetype', },
    },
}

require('blink.cmp').setup {
    completion = {
        list = {
            selection = {
                preselect = false,
                auto_insert = true,
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    signature = { enabled = true, },
    keymap = mappings.blink_mapping,
}

require('nvim-tree').setup {
    actions = {
        change_dir = {
            global = true,
        },
    },
    git = {
        ignore = false,
    },
}

require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local bufopts = { noremap = true, silent = true, buffer = bufnr, }
        mappings.set_gitsigns_mappings(bufopts, gs)
    end,
}

require('mason').setup {
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
}

require('nvim-web-devicons').setup {}
require('nvim-autopairs').setup {}
