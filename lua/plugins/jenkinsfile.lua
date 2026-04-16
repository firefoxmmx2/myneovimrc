return {
  -- Jenkinsfile syntax highlighting
  {
    "jenkinsci/jenkinsfile-syntax-highlighting",
    ft = "groovy",
  },
  
  -- Configure Jenkinsfile file type
  {
    "neovim/nvim-lspconfig",
    opts = {
      filetype = {
        Jenkinsfile = "groovy",
      },
    },
  },
}
