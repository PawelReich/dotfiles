return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  init = function()
    -- Fixes the "Unknown filetype 'razor'" warning
    vim.filetype.add({
      extension = {
        razor = "razor",
        cshtml = "razor",
      },
    })
  end,
  config = function()
    -- Set the configuration natively. 
    -- roslyn.nvim will read this config automatically.
    vim.lsp.config("roslyn", {
      cmd = { 
        "roslyn-language-server", 
        "--stdio", 
        "--autoLoadProjects" 
      },
      -- Add your on_attach or capabilities here if needed
      -- on_attach = require("gtm.core.lsp").on_attach,
      -- capabilities = require("gtm.core.lsp").capabilities,
    })

    -- CRITICAL: Do NOT call vim.lsp.enable("roslyn")
    -- The seblyng/roslyn.nvim plugin handles the starting sequence 
    -- automatically once it resolves your solution/project file.
  end
}
