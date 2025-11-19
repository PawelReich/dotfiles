return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        grep = {
            hidden = true,
            cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob '!.git/'",
        }
    }
}
