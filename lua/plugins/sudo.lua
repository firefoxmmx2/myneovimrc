return {
  "lambdalisue/suda.vim",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>w!!", desc = "Save as root", mode = "n" },
  },
  init = function()
    vim.keymap.set("n", "<leader>w!!", ":SudaWrite<CR>", { desc = "Save as root" })
  end,
}
