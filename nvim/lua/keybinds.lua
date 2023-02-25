-- [[ keybinds.lua ]]

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- remap the key used to leave insert mode
map('i', 'jk', '', {})

map('n', 's', '<Nop>', opts)
-- tag move
map('n', 'st', [[:<C-u>tabnew<CR>]], {})
map('n', 'sn', 'gt', opts)
map('n', 'sp', 'gT', opts)

-- window chenge
map('n', 'sj', '<C-w>j', opts)
map('n', 'sk', '<C-w>k', opts)
map('n', 'sl', '<C-w>l', opts)
map('n', 'sh', '<C-w>h', opts)
-- window move
map('n', 'sJ', '<C-w>J', opts)
map('n', 'sK', '<C-w>K', opts)
map('n', 'sL', '<C-w>L', opts)
map('n', 'sH', '<C-w>H', opts)
-- window split
map('n', 'ss', [[:<C-u>sp<CR>]], opts)
map('n', 'sv', [[:<C-u>vs<CR>]], opts)

map('n', 'sq', [[:<C-u>q<CR>]], opts)

map('n', '<Esc><Esc>', [[:nohlsearch<CR><Esc>]], {})

-- [[Neotree]] Toggle
map('n', '<C-e>', [[:Neotree toggle reveal<CR>]], {})

-- [[easy align]]
vim.cmd([[ xmap ga <Plug>(EasyAlign) ]])
vim.cmd([[ nmap ga <Plug>(EasyAlign) ]])
