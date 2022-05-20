-- [[ nvim-lsp-installer.lua ]]
-- @link https://github.com/williamboman/nvim-lsp-installer

require("nvim-lsp-installer").setup({
  -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  automatic_installation = true,
  ui = {
    icons = {
      server_installed   = "✓",
      server_pending     = "➜",
      server_uninstalled = "✗"
    }
  }
})

