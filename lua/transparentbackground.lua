local groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement', 'PreProc', 'Type', 'Underlined',
    'String', 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn',
    'StatusLine', 'StatusLineNC', 'EndOfBuffer',
}

for _, group in ipairs(groups) do
    local ok, old_attributes = pcall(vim.api.nvim_get_hl, 0, { name = group })
    if ok then
        vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', old_attributes, { bg = 'NONE', }))
    end
end
