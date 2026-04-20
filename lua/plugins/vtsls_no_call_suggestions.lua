return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              suggest = {
                completeFunctionCalls = false,
              },
            },
            javascript = {
              suggest = {
                completeFunctionCalls = false,
              },
            },
          },
        },
      },
    },
  },
}
