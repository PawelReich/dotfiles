vim.g.mapleader = " "
vim.g.maplocalleader = ","

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("v", ">", ">gv")
map("v", "<", "<gv")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" })
map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected up" })

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("n", "<Tab>","<cmd>BufferLineCycleNext<CR>", {desc = "jump to next buffer" })
map("n", "<S-Tab>","<cmd>BufferLineCyclePrev<CR>", {desc = "jump to prev buffer" })

map("n", "<C-n>", "<cmd>Neotree position=float toggle=true reveal=true<CR>", { desc = "Toggle file explorer" })

map("i", "<C-j>", "<nop>")
map("i", "<C-k>", "<nop>")

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find git-files in cwd" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_status<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep_native<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", { desc = "Find symbols" })

vim.keymap.set("n", "s", "<cmd>HopChar2<cr>", { desc = "Hop" })

vim.keymap.set(
  "n",
  "<leader>lg",
  '<cmd>silent !tmux set -w popup-border-lines rounded; tmux popup -E -eTERM=screen-256color -xC -yC -w90\\% -h90\\% -d "'
    .. vim.fn.getcwd()
    .. '" lazygit<cr>',
  { desc = "Lazygit" }
)

local function git_helper(action)
  local script_path = vim.fn.expand("~/.local/bin/git_helper.fish")

  local buffer_name = vim.fn.expand("%:p")
  local cursor_line = vim.fn.line(".")

  local cmd = string.format("fish %s %s %s %s", script_path, action, buffer_name, cursor_line)

  local output = vim.fn.system(cmd)

  if output and output ~= "" then
    vim.notify(output, vim.log.levels.INFO)
  end
end

vim.keymap.set("n", "<leader>gy", function() git_helper("copy-url") end, { desc = "Copy URL" })
vim.keymap.set("n", "<leader>go", function() git_helper("goto-issue") end, { desc = "Goto Issue" })

vim.keymap.set("x", "<leader>s", '"vy:%s/\\V<C-r>v//g<Left><Left>', { desc = 'Search and Replace Selection' })
