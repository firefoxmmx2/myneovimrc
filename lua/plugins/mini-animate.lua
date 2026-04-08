return {
  "nvim-mini/mini.animate",
  event = "VeryLazy",
  cond = vim.g.neovide == nil,
  opts = function(_, opts)
    local animate = require("mini.animate")
    
    return vim.tbl_deep_extend("force", opts, {
      cursor = {
        enable = true,
        timing = animate.gen_timing.bounce({
          duration = 80,
          max_step = 8,
        }),
      },
      scroll = {
        enable = true,
        timing = animate.gen_timing.bounce({
          duration = 100,
          max_step = 10,
        }),
      },
      resize = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
      },
      open = {
        enable = true,
        timing = animate.gen_timing.bounce({
          duration = 150,
          max_step = 10,
        }),
      },
      close = {
        enable = true,
        timing = animate.gen_timing.bounce({
          duration = 100,
          max_step = 8,
        }),
      },
    })
  end,
}
