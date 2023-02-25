-- [[ packer.lua ]]
-- @link https://github.com/wbthomason/packer.nvim

vim.cmd[[packadd packer.nvim]]

require('packer').startup(function()
  -- 起動時に読み込むプラグインは名前を書くだけです
  use'tpope/vim-fugitive'
  -- use'tpope/vim-repeat'

  -- start screen
  use {
    'goolord/alpha-nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function ()
      require('alpha').setup(require'alpha.themes.startify'.config)
    end
  }

  -- language server protocol
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  -- use {
  --   'williamboman/nvim-lsp-installer',
  --   'neovim/nvim-lspconfig',
  -- }

  -- linter, formatter
  use "jose-elias-alvarez/null-ls.nvim"

  -- tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {'yioneko/nvim-yati'}
  }

  -- file exproler
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- git
  use {'lewis6991/gitsigns.nvim'}

  -- completion engine
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  }

  -- color view
  use {'norcalli/nvim-colorizer.lua'}

  -- colorscheme
  -- use {'brendonrapp/smyck-vim'}
  use {'amizok/onedark.nvim'}
  use {'sainnhe/sonokai'}
  use {'rebelot/kanagawa.nvim'}
  use {'edeneast/nightfox.nvim'}

  use {'junegunn/vim-easy-align'}

  -- opt オプションを付けると遅延読み込みになります。
  -- この場合は opt だけで読み込む契機を指定していないため、
  -- `packadd` コマンドを叩かない限り読み込まれることはありません。
  use{'wbthomason/packer.nvim', opt = true}
  -- packer.nvim 自体を遅延読み込みにする理由はまた後ほど。

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- filetype
  use("nathom/filetype.nvim")

  -- コマンドを叩いたときに読み込む。
  -- use{'rhysd/git-messenger.vim', opt = true, cmd = {'GitMessenger'}}

  -- 特定のイベントで読み込む
  -- use{'tpope/vim-unimpaired', opt = true, event = {'FocusLost', 'CursorHold'}}

  -- 特定のファイルタイプのファイルを開いたら読み込む
  -- use{'fatih/vim-go', opt = true, ft = {'go'}}

  -- 特定のキーを叩いたら読み込む
  -- この例でノーマルモードの <CR> にマッピングしていますが、
  -- モードを指定する場合はテーブルを入れ子にします。
  -- keys = {
  --   {'n', '<CR>'},
  --   {'v', '<CR>'},
  -- }
  -- use{
  --   'arecarn/vim-fold-cycle',
  --   opt = true,
  --   keys = {'<CR>'},
  -- }

  -- 特定の VimL 関数を呼ぶと読み込む
  -- この例だと、任意の場所で Artify('hoge', 'bold') のように呼び出された時に、
  -- このプラグインも読み込まれます。
  -- use{'sainnhe/artify.vim', opt = true, fn = {'Artify'}},

  -- 実は opt = true は省略できます。読み込む契機（この例では cmd）を指定すると、
  -- 自動的に遅延読み込みとみなされます。
  -- use{
  --   'npxbr/glow.nvim',
  --   cmd = {'Glow', 'GlowInstall'},
  --   -- run オプションを指定すると、インストール時・更新時に
  --   -- 実行するコマンドを指定できます。
  --   run = [[:GlowInstall]],
  --   -- 先頭に : がついていないなら bash -c '...' で実行されます。
  --   -- run = [[npm install]],
  --   -- 関数も指定可能です。
  --   -- run = function() vim.cmd[[GlowInstall]] end,
  -- }

  -- -- 条件が真の時のみ読み込みます。条件は起動時に毎回判定されます。
  -- use{
  --   'thinca/vim-fontzoom',
  --   cond = [[vim.fn.has'gui' == 1]], -- GUI の時のみ読み込む。
  --   -- 関数も指定できます。
  --   -- conf = function() return vim.fn.has'gui' == 1 end,
  -- }

  -- -- 依存関係も管理できます。vim-prettyprint は
  -- -- capture.vim が読み込まれる前に、自動的に packadd されます。
  -- use{
  --   'tyru/capture.vim',
  --   requires = {
  --     {'thinca/vim-prettyprint', cmd = {'PP', 'PrettyPrint'}},
  --   },
  --   cmd = {'Capture'},
  -- }
end)

