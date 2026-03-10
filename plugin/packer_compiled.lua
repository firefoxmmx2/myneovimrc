-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/firefoxmmx/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?.lua;/home/firefoxmmx/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?/init.lua;/home/firefoxmmx/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?.lua;/home/firefoxmmx/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/firefoxmmx/.cache/nvim/packer_hererocks/2.1.1748459687/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Jenkinsfile-vim-syntax"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/Jenkinsfile-vim-syntax",
    url = "git@github.com:martinda/Jenkinsfile-vim-syntax"
  },
  ["argtextobj.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/argtextobj.vim",
    url = "git@github.com:vim-scripts/argtextobj.vim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "git@github.com:skywind3000/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/asynctasks.vim",
    url = "git@github.com:skywind3000/asynctasks.vim"
  },
  ["blamer.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/blamer.nvim",
    url = "git@github.com:APZelos/blamer.nvim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "git@github.com:neoclide/coc.nvim"
  },
  ["codeium.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/codeium.vim",
    url = "git@github.com:Exafunction/codeium.vim"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "git@github.com:github/copilot.vim"
  },
  cpsm = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/cpsm",
    url = "git@github.com:nixprime/cpsm"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "git@github.com:glepnir/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "git@github.com:sindrets/diffview.nvim"
  },
  ["docker-compose.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/docker-compose.vim",
    url = "git@github.com:skanehira/docker-compose.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "git@github.com:mattn/emmet-vim"
  },
  ["fcitx.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/fcitx.vim",
    url = "git@github.com:lilydjwg/fcitx.vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "git@github.com:junegunn/fzf.vim"
  },
  ["fzy-lua-native"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/fzy-lua-native",
    url = "git@github.com:romgrk/fzy-lua-native"
  },
  ["glow.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tglow\frequire\0" },
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "git@github.com:ellisonleao/glow.nvim"
  },
  ["jad.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/jad.vim",
    url = "git@github.com:chenillen/jad.vim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "git@github.com:kdheepak/lazygit.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "git@github.com:scrooloose/nerdcommenter"
  },
  ["nerdfont.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/nerdfont.vim",
    url = "git@github.com:lambdalisue/nerdfont.vim"
  },
  ["nerdtree-git-plugin"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/nerdtree-git-plugin",
    url = "git@github.com:xuyuanp/nerdtree-git-plugin"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "git@github.com:nvim-treesitter/nvim-treesitter"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/onedark.vim",
    url = "git@github.com:joshdick/onedark.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "git@github.com:nvim-lua/plenary.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/rainbow",
    url = "git@github.com:luochen1990/rainbow"
  },
  tagbar = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/tagbar",
    url = "git@github.com:majutsushi/tagbar"
  },
  ultisnips = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "git@github.com:sirver/ultisnips"
  },
  ["vc.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vc.vim",
    url = "git@github.com:juneedahamed/vc.vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "git@github.com:vim-airline/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-airline-themes",
    url = "git@github.com:vim-airline/vim-airline-themes"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "git@github.com:ryanoasis/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "git@github.com:easymotion/vim-easymotion"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "git@github.com:voldikss/vim-floaterm"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-mundo",
    url = "git@github.com:simnalamburt/vim-mundo"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "git@github.com:honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "git@github.com:tpope/vim-surround"
  },
  ["vim-table-mode"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/vim-table-mode",
    url = "git@github.com:dhruvasagar/vim-table-mode"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/wilder.nvim",
    url = "git@github.com:gelguy/wilder.nvim"
  },
  ["wildfire.vim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/wildfire.vim",
    url = "git@github.com:gcmt/wildfire.vim"
  },
  ["yaml.nvim"] = {
    loaded = true,
    path = "/home/firefoxmmx/.local/share/nvim/site/pack/packer/start/yaml.nvim",
    url = "git@github.com:cuducos/yaml.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: glow.nvim
time([[Config for glow.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tglow\frequire\0", "config", "glow.nvim")
time([[Config for glow.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
