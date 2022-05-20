-- [[ plugins.lua ]]

-- plugin manager
require('plugins.packer')
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

require('plugins.nvim-lspconfig')
require('plugins.nvim-lsp-installer')
require('plugins.telescope')
require('plugins.lualine')
require('plugins.nvim-treesitter')
require('plugins.neo-tree')
require('plugins.onedark')
require('plugins.nvim-cmp')
require('gitsigns').setup()
require('colorizer').setup()
