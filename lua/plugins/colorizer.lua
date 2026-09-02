return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        rgb_fn = true,
        css = true,
        mode = "background",
      },
    },
  },
}
