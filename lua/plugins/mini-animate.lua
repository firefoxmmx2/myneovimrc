return {
  "nvim-mini/mini.animate",
  event = "VeryLazy",
  cond = vim.g.neovide == nil,
  opts = function(_, opts)
    local animate = require("mini.animate")

    return vim.tbl_deep_extend("force", opts, {
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 250, unit = "total" }),
      },
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 250, unit = "total" }),
      },
      resize = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 250, unit = "total" }),
      },
      open = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 250, unit = "total" }),
      },
      close = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
      },
    })
  end,
}
