return {
  "lambdalisue/suda.vim",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>w!!", desc = "Save as root", mode = "n" },
  },
  init = function()
    vim.g.suda_smart_edit = 1
    vim.keymap.set("n", "<leader>w!!", ":SudaWrite<CR>", { desc = "Save as root" })
  end,
}
