-- [[ plugins.lua ]]

-- plugin manager
require('plugins.packer')
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

require('plugins.mason')
-- require('plugins.nvim-lsp-installer')
require('plugins.nvim-lspconfig')
require('plugins.telescope')
require('plugins.nvim-treesitter')
require('plugins.neo-tree')
require('plugins.color-theme')
require('plugins.nvim-cmp')
require('plugins.filetype')
require('plugins.lualine')
require('gitsigns').setup()
require('colorizer').setup()

