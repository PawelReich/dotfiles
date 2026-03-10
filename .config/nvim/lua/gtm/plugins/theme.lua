return {
  {
    "echasnovski/mini.base16",
    version = false,
    priority = 1000,
    config = function()
      local my_palette = require("colors")

      require("mini.base16").setup({
        palette = my_palette,
        use_cterm = true,
      })
        local hl = vim.api.nvim_set_hl
      
      -- Force the tabline fill to match your main background
      hl(0, "TabLineFill", { bg = my_palette.base00 })
      hl(0, "BufferLineFill", { bg = my_palette.base00 })
      
      -- Make the icon backgrounds transparent so they blend seamlessly
      hl(0, "BufferLineBackground", { bg = "NONE" })
      hl(0, "BufferLineIcon", { bg = "NONE" })
      hl(0, "BufferLineDevIconDefault", { bg = "NONE" })
      hl(0, "BufferLineDevIconDefaultSelected", { bg = "NONE" })
      hl(0, "BufferLineDevIconDefaultInactive", { bg = "NONE" })
    end,
  }
}
