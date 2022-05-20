-- [[ telescope.lua ]]
-- @link https://github.com/nvim-telescope/telescope.nvim

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<Space>f', "<cmd>Telescope git_files<CR>", opts)
vim.api.nvim_set_keymap('n', '<Space>F', "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap('n', '<Space>g', "<cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files <CR>", opts)
vim.api.nvim_set_keymap('n', '<Space>b', "<cmd>Telescope buffers<CR>", opts)
