return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      root_dir = function(path)
        return vim.fs.root(path, ".git") or vim.fs.root(path, "pom.xml")
      end,
      dap_main = {
        config_overrides = {
          console = "integratedTerminal",
        },
      },
    },
  },
}
