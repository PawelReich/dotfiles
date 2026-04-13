vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
    vim.bo[args.buf].omnifunc = nil

    local opts = { silent = true }
    opts.desc = "Show LSP references"
    vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Show LSP definitions"
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    opts.desc = "Show LSP implementations"
    vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

    opts.desc = "See available code actions"
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show buffer diagnostics"
    vim.keymap.set("n", "<leader>D", "<cmd>FzfLua diagnostics_document<CR>", opts)

    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, opts)

    vim.diagnostic.config({ virtual_lines = { 
            current_line = true,
        },
        underline = false,
    })

end,
})

vim.lsp.config("*", {
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
        if client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end
    end,
})
vim.keymap.set("i", "<CR>", function()
  -- If the popup menu is visible, accept the selection with <C-y>
  -- Otherwise, just pass a normal <CR>
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, desc = "Accept completion" })

vim.lsp.config("roslyn", {
  cmd = { 
    "roslyn-language-server", 
    "--stdio", 
    "--autoLoadProjects" 
  },
})

vim.lsp.enable("robotframework_ls")
vim.lsp.enable("ty")
vim.lsp.enable("phpactor")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
