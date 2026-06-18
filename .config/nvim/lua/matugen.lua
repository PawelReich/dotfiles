 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1f2430',
    base01 = '#1e222a',
    base02 = '#171b24',
    base03 = '#686868',
    base04 = '#8e959e',
    base05 = '#d1d1c7',
    base06 = '#c7c7c7',
    base07 = '#ffffff',
    base08 = '#ed8274',
    base09 = '#ffcc66',
    base0A = '#facc6e',
    base0B = '#87d96c',
    base0C = '#90e1c6',
    base0D = '#6dcbfa',
    base0E = '#dabafa',
    base0F = '#f28779',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#d1d1c7',          bg = '#1f2430' })
  hi('TelescopeBorder',         { fg = '#686868',             bg = '#1f2430' })
  hi('TelescopePromptNormal',   { fg = '#d1d1c7',          bg = '#1f2430' })
  hi('TelescopePromptBorder',   { fg = '#686868',             bg = '#1f2430' })
  hi('TelescopePromptPrefix',   { fg = '#e6b450',             bg = '#1f2430' })
  hi('TelescopePromptCounter',  { fg = '#8e959e',  bg = '#1f2430' })
  hi('TelescopePromptTitle',    { fg = '#1f2430',             bg = '#e6b450' })
  hi('TelescopePreviewTitle',   { fg = '#1f2430',             bg = '#6dcbfa' })
  hi('TelescopeResultsTitle',   { fg = '#1f2430',             bg = '#87d96c' })
  hi('TelescopeSelection',      { fg = '#d1d1c7',          bg = '#171b24' })
  hi('TelescopeSelectionCaret', { fg = '#e6b450',             bg = '#171b24' })
  hi('TelescopeMatching',       { fg = '#e6b450',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
