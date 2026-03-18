return {
  "khoido2003/roslyn-filewatch.nvim",
  build = "nvim -l build.lua --", -- Compiles or downloads the Native Rust module fallback
  config = function()
    require("roslyn_filewatch").setup()
  end,
}
