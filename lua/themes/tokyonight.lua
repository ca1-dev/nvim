require('tokyonight').setup {
    lualine_bold = true,
}

vim.cmd.colorscheme('tokyonight-night')

-- make git additions green instead of cyan
vim.cmd('hi GitSignsAdd guifg=#c3e88d')
