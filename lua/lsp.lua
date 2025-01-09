local lsp = require('lspconfig')

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- remove diagnostic characters from sign column and highlight line numbers of diagnostics
local dsigns = { 'DiagnosticSignError', 'DiagnosticSignWarn', 'DiagnosticSignHint', 'DiagnosticSignInfo', }
for _, s in pairs(dsigns) do
    vim.fn.sign_define(s, { text = '', texthl = s, numhl = s, })
end

-- format the current buffer using null-ls config if available, otherwise use
-- any other available formatter
local function format(bufnr)
    vim.lsp.buf.format {
        filter = function(client)
            local null_ls = vim.lsp.get_clients({ name = 'null-ls', })[1]
            if (null_ls and vim.lsp.buf_is_attached(bufnr, null_ls.id)) then
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

local null_ls = require('null-ls')
null_ls.setup { sources = { null_ls.builtins.formatting.prettier, }, }

require('mason-lspconfig').setup_handlers {
    function(server_name)
        lsp[server_name].setup { on_attach = on_attach, capabilities = capabilities, }
    end,

    ['lua_ls'] = function()
        lsp.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = { globals = {}, },
                    workspace = {
                        checkThirdParty = false,

                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                    telemetry = { enable = false, },
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
}

-- use system clangd if mason clangd is not installed
lsp.clangd.setup { on_attach = on_attach, capabilities = capabilities, }
