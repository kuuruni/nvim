return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "tsgo",
        "pyright",
        "gopls",
        "rust_analyzer",
        "clangd",
        "vue_ls",
        "svelte",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
        tsgo = {},
        pyright = {},
        gopls = {},
        rust_analyzer = {},
        clangd = {},
        vue_ls = {},
        svelte = {},
      },
    },
  },
}
