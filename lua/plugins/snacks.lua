return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      enabled = true,
      hidden = false,
      ignored = true,
      exclude = {
        "node_modules",
      },
      sources = {
        explorer = {
          hidden = false,
          ignored = true,
          auto_close = false,
        },

        files = {
          hidden = false,
          ignored = true,
        },

        grep = {
          hidden = false,
          ignored = true,
        },

        buffer = {
          current = false,
        },

        recent = {
          filter = { cwd = true },
        },
      },
    },

    dashboard = {
      enabled = true,
      preset = {
        header = [[
▄   ▄ ▄▄▄▄  ▄ ▄   ▄ ▄▄▄▄  ▗▞▀▜▌
 ▀▄▀  █   █ ▄  ▀▄▀  █ █ █ ▝▚▄▟▌
▄▀ ▀▄ █   █ █ ▄▀ ▀▄ █   █      
            █                  
        ]],
        keys = {
          { icon = "󰍉 ", key = "f", desc = "Find File", action = function() Snacks.picker.files() end },
          { icon = " ", key = "r", desc = "Recent Files", action = function() Snacks.picker.recent() end },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = "󰈔 ",
            key = "c",
            desc = "Config",
            action = function()
              require("snacks").explorer({
                cwd = vim.fn.expand("~/.config/nvim"),
              })
            end,
          },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
          { icon = "󰒲 ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "󰩈 ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
