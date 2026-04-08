return {
  "nvim-mini/mini.nvim",
  version = false,
  opts = {
    animate = {
      cursor = {
        enable = true,
        timing = {
          duration = 150,
          easing = function(t) return 1 - math.cos(t * math.pi / 2) end,
        },
      },
      scroll = {
        enable = true,
        timing = {
          duration = 200,
          easing = function(t) return t * (2 - t) end,
        },
      },
      resize = {
        enable = true,
        timing = {
          duration = 150,
          easing = function(t) return t * (2 - t) end,
        },
      },
      open = {
        enable = true,
        timing = {
          duration = 200,
          easing = function(t) return t * (2 - t) end,
        },
      },
      close = {
        enable = true,
        timing = {
          duration = 150,
          easing = function(t) return t * t end,
        },
      },
    },
  },
}
