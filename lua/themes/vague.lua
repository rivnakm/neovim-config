return {
  "vague2k/vague.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other plugins
  config = function()
    require("vague").setup({
      on_highlights = function(highlights, colors)
        highlights.BufferCurrent = { fg = colors.fg, bg = colors.bg }
        highlights.BufferCurrentMod = { fg = colors.warning, bg = colors.bg }
        highlights.BufferInactive = { fg = colors.floatBorder, bg = colors.inactiveBg }
        highlights.BufferAlternate = { bg = colors.inactiveBg }
        highlights.BufferVisible = { bg = colors.inactiveBg }
      end
    })
    vim.cmd.colorscheme("vague")
  end
}
