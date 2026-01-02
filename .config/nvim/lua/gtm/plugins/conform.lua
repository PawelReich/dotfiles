return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
      },

      format_on_save = function(bufnr)
        local format_filetypes = { "cs", "python" }
        if not vim.tbl_contains(format_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return { timeout_ms = 500, lsp_format = "prefer" }
      end,
    })

    vim.keymap.set("n", "<leader>fm", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file" })
  end,
}

