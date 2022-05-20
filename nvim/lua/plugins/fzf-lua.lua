-- [[fzf-lua.lua]]
-- @link https://github.com/ibhagwan/fzf-lua

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<Space>f', "<cmd>lua require('fzf-lua').files()<CR>", opts)
vim.api.nvim_set_keymap('n', '<Space>F', "<cmd>lua require('fzf-lua').git_files()<CR>",opts)
vim.api.nvim_set_keymap('n', '<Space>b', "<cmd>lua require('fzf-lua').buffers()<CR>",opts)
vim.api.nvim_set_keymap('n', '<Space>g', "<cmd>lua require('fzf-lua').grep()<CR>", opts)

