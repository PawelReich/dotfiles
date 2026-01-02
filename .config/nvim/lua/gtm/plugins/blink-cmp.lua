return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",

      ["<CR>"] = { "accept", "fallback" },
      ["<C-n>"] = {
        "select_next",
        "snippet_forward",
        "fallback",
      },
      ["<C-p>"] = {
        "select_prev",
        "snippet_backward",
        "fallback",
      },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = { documentation = { auto_show = true } },

    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "lua" },
  },
  opts_extend = { "sources.default" },
}
