vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('plugins.lazy')

-- load theme based on environment variable
local env_theme = vim.fn.expand('$THEME')
local theme_file = io.open(vim.fn.expand('$HOME') .. '/.config/nvim/lua/themes/' .. env_theme .. '.lua', 'r')
if theme_file then
    io.close(theme_file)
    require('themes.' .. env_theme)
else
    require('themes.tokyonight')
end

require('options')
require('mappings')
require('plugins.plugin_config')
require('lsp')
require('autocmds')
require('transparentbackground')
