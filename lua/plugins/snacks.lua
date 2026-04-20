return {
  "folke/snacks.nvim",
  opts = {
    picker = { enabled = true },
    explorer = { enabled = true },
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
          { icon = "󰍉 ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
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
