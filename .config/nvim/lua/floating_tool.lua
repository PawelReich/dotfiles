-- https://github.com/kamil-koziol/nvim/blob/main/init.lua

function open_floating_tool(cmd, on_exit_callback)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_option_value(
    'winhl', 
    'NormalFloat:Normal,FloatBorder:Normal', 
    { win = win }
  )
  -- Use the built-in :terminal command which is the replacement for termopen
  -- We use 'startinsert' to immediately focus the terminal
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")

  -- Track the process to handle the exit callback
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      vim.api.nvim_win_close(win, true)
      vim.cmd("bdelete! " .. buf)
      if on_exit_callback then
        on_exit_callback()
      end
    end,
  })
end
