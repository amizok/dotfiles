-- [[ mason.lua ]]
-- @link https://github.com/williamboman/mason.nvim

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
    -- ensure_installed = { "sumneko_lua", "pyright" }
    ensure_installed = { "pylsp" }
})
