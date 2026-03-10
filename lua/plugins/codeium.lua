return {
  "Exafunction/windsurf.vim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      -- configuration
      use({
        "Exafunction/windsurf.vim",
        config = function()
          -- Change '<C-g>' here to any keycode you like.
          vim.keymap.set("i", "<C-g>", function()
            return vim.fn["codeium#Accept"]()
          end, { expr = true, silent = true })
          vim.keymap.set("i", "<c-;>", function()
            return vim.fn["codeium#CycleCompletions"](1)
          end, { expr = true, silent = true })
          vim.keymap.set("i", "<c-,>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
          end, { expr = true, silent = true })
          vim.keymap.set("i", "<c-x>", function()
            return vim.fn["codeium#Clear"]()
          end, { expr = true, silent = true })
        end,
      }),
    })
  end,
}

-- codeium settings
--
-- codeium airline#SetStatus setting
-- 简化fn vim函数符号
