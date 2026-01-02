return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function ()
        require('gitblame').setup {
            enabled = false,
        }

        vim.keymap.set("n", "<leader>gb", "<cmd>:GitBlameToggle<cr>", { desc = "Toggle git blame" })
    end
}
