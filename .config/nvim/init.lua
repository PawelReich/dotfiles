require("options")
require("floating_tool")

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/mbbill/undotree",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-mini/mini.base16",
    "https://github.com/nvim-mini/mini.notify",
    "https://github.com/nvim-mini/mini.indentscope",
    "https://github.com/nvim-mini/mini.clue",
    "https://github.com/seblyng/roslyn.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/folke/persistence.nvim",
    "https://github.com/skosulor/nibbler",
    "https://github.com/smiteshP/nvim-navic",
    "https://github.com/catgoose/nvim-colorizer.lua",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

-- Theme

local palette = require("colors")
require("mini.base16").setup({
    palette = palette,
    use_cterm = true,
})
local hl = vim.api.nvim_set_hl

hl(0, "TabLineFill", { bg = palette.base00 })
hl(0, "BufferLineFill", { bg = palette.base00 })
hl(0, "BufferLineBackground", { bg = "NONE" })
hl(0, "BufferLineIcon", { bg = "NONE" })
hl(0, "BufferLineDevIconDefault", { bg = "NONE" })
hl(0, "BufferLineDevIconDefaultSelected", { bg = "NONE" })
hl(0, "BufferLineDevIconDefaultInactive", { bg = "NONE" })
hl(0, "MiniIndentscopeSymbol", { fg = palette.base02 })

--

require("nvim-treesitter.config").setup({
    highlight = { enable = true },
    auto_install = true,
})

require("mini.clue").setup()

require("mini.notify").setup()

require("mini.indentscope").setup({
    delay = 0,
    symbol = "│",
})

require("gitsigns").setup()

require('nibbler').setup ({
    display_enabled = true,
})

require("conform").setup({
    format_on_save = function(bufnr)
        local format_filetypes = { "cs", "python", "cpp" }
        if not vim.tbl_contains(format_filetypes, vim.bo[bufnr].filetype) then
            return
        end

        return { timeout_ms = 2500, lsp_format = "prefer" }
    end,
})

require("colorizer").setup({
    user_default_options = {
        names = false,
        css = true,
    }
})

require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            visible = true,
            hide_gitignored = true,
            hide_dotfiles = false,
            never_show = { ".git" },
        },
    }
})

require("fzf-lua").setup({
    hidden = true,
    cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob '!.git/'",
})

require("bufferline").setup()

-- Lualine

local function get_last_segment(path)
    local segments = {}
    for segment in string.gmatch(path, "[^/]+") do
        table.insert(segments, segment)
    end
    return segments[#segments]
end

local lualine_lsp_clients = function()
    local bufnr = vim.api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
        return ""
    end

    local c = {}
    for _, client in pairs(clients) do
        table.insert(c, client.name)
    end
    return " " .. table.concat(c, "|")
end

local lualine_current_solution = function()
    local sol = ""
    if not (vim.g.roslyn_nvim_selected_solution == nil or vim.g.roslyn_nvim_selected_solution == '') then
        sol = get_last_segment(vim.g.roslyn_nvim_selected_solution)
    end
    return sol
end

require("lualine").setup({
    sections = {
        lualine_a = { { "mode" } },
        lualine_b = { 
            { "filetype", icon_only = true, padding = { left = 1, right = 0 }, },
            "filename",
            { "navic", color_correction = "dynamic" },
        },
        lualine_c = {
            { "branch" },
            { "diff", symbols = { added = " ", modified = " ", removed = " " }, colored = false, },
        },
        lualine_x = {
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " }, update_in_insert = true, },
        },
        lualine_y = { lualine_lsp_clients, lualine_current_solution },
        lualine_z = { { "location" } },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    extensions = { "toggleterm", "trouble" },
})

--

require("keymaps")
require("lsp")
