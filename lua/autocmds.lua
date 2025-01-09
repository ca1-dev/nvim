-- replace empty buffer with nvim-tree if no arguments given
-- if one directory is given as an argument, open it in nvim-tree
vim.api.nvim_create_autocmd({ 'VimEnter', }, {
    callback = function()
        if vim.fn.argc() == 0 then
            local emptybuffer = vim.api.nvim_get_current_buf()
            vim.cmd.NvimTreeOpen()
            vim.api.nvim_buf_delete(emptybuffer, {})
        end
        local argv = vim.fn.argv()
        if vim.fn.argc() == 1 and vim.fn.isdirectory(argv[1]) ~= 0 then
            vim.cmd.NvimTreeOpen({ path = argv[1], })
        end
    end,
})

-- set format options on buffer enter
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', }, {
    command = 'setlocal formatoptions-=ro',
})
