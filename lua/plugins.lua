vim.cmd([[packadd packer.nvim]])

local packer = require('packer')
packer.init({
  git = {
    default_url_format = 'git@github.com:%s'
  },
})

return  packer.startup(function()
  use 'gcmt/wildfire.vim'
  use 'tpope/vim-surround'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'luochen1990/rainbow'
  use 'xuyuanp/nerdtree-git-plugin'
  use 'scrooloose/nerdcommenter'
  use 'majutsushi/tagbar'
  use 'sirver/ultisnips'
  use 'honza/vim-snippets'
  use 'junegunn/fzf.vim'
  use 'mattn/emmet-vim'
  use 'juneedahamed/vc.vim'
  use 'joshdick/onedark.vim'
  use 'lilydjwg/fcitx.vim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'glepnir/dashboard-nvim'
  use 'dhruvasagar/vim-table-mode'
  -- use 'puremourning/vimspector'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'skywind3000/asynctasks.vim'
  use 'skywind3000/asyncrun.vim'
  use 'easymotion/vim-easymotion'
  use 'voldikss/vim-floaterm'
  use 'martinda/Jenkinsfile-vim-syntax'
  use 'chenillen/jad.vim'
  use 'cuducos/yaml.nvim'
  use 'APZelos/blamer.nvim'
  use 'ryanoasis/vim-devicons'
  use 'Exafunction/codeium.vim'
  use 'skanehira/docker-compose.vim'
  -- use 'ggandor/leap.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'gelguy/wilder.nvim'
  use 'nixprime/cpsm'
  use 'romgrk/fzy-lua-native'
  use 'lambdalisue/nerdfont.vim'
  -- nvim v0.7.2
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use 'vim-scripts/argtextobj.vim'
  use 'simnalamburt/vim-mundo'
  use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}
end)

