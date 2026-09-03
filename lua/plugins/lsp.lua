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
        "pyright",
        "gopls",
        "rust_analyzer",
        "clangd",
        "vue_ls",
        "svelte",
        "tailwindcss",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local configs = require("lspconfig.configs")
      if not configs.tsgo then
        configs.tsgo = {
          default_config = {
            cmd = { "tsgo", "lsp", "--stdio" },
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
            root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
            single_file_support = true,
          },
        }
      end

      opts.inlay_hints = { enabled = false }
      opts.servers = opts.servers or {}
      opts.servers.lua_ls = {
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
      }
      opts.servers.tsgo = {}
      opts.servers.tailwindcss = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
      }
    end,
  },
}
