return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_gitignored = true,
                hide_dotfiles = false,
                never_show = { ".git" },
            },
        },
    },
}
