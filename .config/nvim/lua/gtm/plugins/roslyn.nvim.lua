return {
  "seblyng/roslyn.nvim",
  ft = { "cs" },
  config = function()
    vim.lsp.config("roslyn", {
      cmd = { 
        "roslyn-language-server", 
        "--stdio", 
        "--autoLoadProjects" 
      },
    })
  end
}
