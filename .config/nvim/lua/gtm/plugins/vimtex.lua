return {
    "lervag/vimtex",
    lazy = true,
    ft = "tex",
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_view_forward_search_on_start = false
        vim.g.tex_conceal='abdmg'
        vim.cmd([[autocmd BufEnter *.tex set conceallevel=1]])
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = vim.fn.stdpath("cache") .. "/vimtex_aux",
            options = {
                '-verbose',
                '-file-line-error',
                '-synctex=1',
                '-interaction=nonstopmode',
                '--shell-escape',
            }
        }
        -- vim.g.vimtex_quickfix_enabled = 0
        vim.g.vimtex_quickfix_mode = 2
        vim.g.vimtex_quickfix_enabled = 0
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
    end
}
