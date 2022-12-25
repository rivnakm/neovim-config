local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Github Neovim Theme
  use({
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup({
        theme_style = "dark_default",
      })
    end
  })

  -- Treesitter
  use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
  }

  -- Devicons
  use 'nvim-tree/nvim-web-devicons'

  -- Galaxyline
  use({
    "NTBBloodbath/galaxyline.nvim",
    -- your statusline
    config = function()
      require("galaxyline.theme")
    end,
    -- some optional icons
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  })

  -- Barbar
  use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

  -- nvim-colorizer
  use 'NvChad/nvim-colorizer.lua'

  -- Bootstrap packer
  if packer_bootstrap then
	  require("packer").sync()
  end
end)
