vim.keymap.set(
    { 'n', 't', 'i', },
    '<c-\'>',
    function() vim.cmd.Termtoggle() end,
    { noremap = true, silent = true, }
)

local state = {
    buf = -1,
    win = -1,
}

local function create_window(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win = vim.api.nvim_open_win(buf, true, {
        vertical = false,
        win = -1,
        height = 20,
        style = 'minimal',
    })

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.win) then
        state = create_window(state.buf)
        if vim.bo[state.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
        vim.cmd.wincmd('J')
        vim.api.nvim_command('startinsert')
    else
        vim.api.nvim_win_close(state.win, true)
    end
end

vim.api.nvim_create_user_command("Termtoggle", toggle_terminal, {})
