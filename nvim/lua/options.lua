-- [[ options.lua ]]
local cmd = vim.api.nvim_command

-- window options
vim.wo.number = true
vim.wo.list = true
vim.wo.listchars = "tab:>-,trail:-,nbsp:%,extends:>,precedes:<"

-- options
vim.opt.syntax = 'OFF'
vim.opt.termguicolors = ture
vim.opt.helpheight = 999
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"
vim.opt.ambiwidth = "single"
vim.opt.laststatus = 2
vim.opt.cmdheight = 1
vim.opt.ttm = 0

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

-- color scheme
-- cmd('colorscheme onedark')
cmd('colorscheme nightfox')

-- wsl only.
-- lsp-serverをwindowsのユーザディレクトリにインストールする場合があるので指定する
vim.cmd([[ let g:lsp_settings_extra_paths=['/mnt/c/Users/admin-dev'] ]])
