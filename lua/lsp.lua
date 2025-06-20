local lsp = require('lspconfig')
local null_ls = require('null-ls')
local blink = require('blink.cmp')

local capabilities = blink.get_lsp_capabilities()

-- remove diagnostic characters from sign column and highlight line numbers of diagnostics
local s = vim.diagnostic.severity
vim.diagnostic.config({
    virtual_text = {},
    signs = {
        text = {
            [s.ERROR] = '',
            [s.WARN] = '',
            [s.INFO] = '',
            [s.HINT] = '',
        },
        numhl = {
            [s.ERROR] = 'DiagnosticSignError',
            [s.WARN] = 'DiagnosticSignWarn',
            [s.INFO] = 'DiagnosticSignHint',
            [s.HINT] = 'DiagnosticSignInfo',
        },
    },
})

-- format the current buffer using null-ls config if available, otherwise use
-- any other available formatter
local function format(bufnr)
    vim.lsp.buf.format {
        filter = function(client)
            local null_ls_clients = vim.lsp.get_clients({ name = 'null-ls', })[1]
            if (null_ls_clients and vim.lsp.buf_is_attached(bufnr, null_ls.id)) then
                return client.name == 'null-ls'
            else
                return true
            end
        end,
    }
end

local function on_attach(_, bufnr)
    -- keymaps
    local bufopts = { noremap = true, silent = true, buffer = bufnr, }
    require('mappings').set_lsp_mappings(bufopts, format)

    -- format on save
    vim.api.nvim_create_autocmd({ 'BufWritePre', }, {
        buffer = bufnr,
        callback = function() format(bufnr) end,
    })
end

require('mason-lspconfig').setup {
    ensure_installed = {},
}

require('mason-null-ls').setup {
    automatic_installation = false,
    ensure_installed = {},
}

null_ls.setup { sources = { null_ls.builtins.formatting.prettier, }, }

vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- use system clangd if mason clangd is not installed
lsp.clangd.setup { on_attach = on_attach, capabilities = capabilities, }
