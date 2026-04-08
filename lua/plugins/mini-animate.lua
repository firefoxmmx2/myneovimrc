return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require('mini.animate').setup({
      cursor = {
        enable = true,
        timing = require('mini.animate').default_timing({
          duration = 150,
          easing = require('mini.animate').easing.out_sine,
        }),
      },
      scroll = {
        enable = true,
        timing = require('mini.animate').default_timing({
          duration = 200,
          easing = require('mini.animate').easing.out_quad,
        }),
      },
      resize = {
        enable = true,
        timing = require('mini.animate').default_timing({
          duration = 150,
          easing = require('mini.animate').easing.out_quad,
        }),
      },
      open = {
        enable = true,
        timing = require('mini.animate').default_timing({
          duration = 200,
          easing = require('mini.animate').easing.out_quad,
        }),
      },
      close = {
        enable = true,
        timing = require('mini.animate').default_timing({
          duration = 150,
          easing = require('mini.animate').easing.in_quad,
        }),
      },
    })
  end,
}
