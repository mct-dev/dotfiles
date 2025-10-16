-- CodeCompanion Spinner using virtual lines
-- Based on: https://github.com/olimorris/codecompanion.nvim/discussions/640

local M = {}

-- Spinner configuration
M.config = {
  frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  interval = 80, -- milliseconds between frames
  hl_group = "DiagnosticInfo",
}

-- State
M.state = {
  timer = nil,
  frame_idx = 1,
  namespace = vim.api.nvim_create_namespace("codecompanion_spinner"),
  extmark_id = nil,
  bufnr = nil,
}

-- Start the spinner
function M.start()
  if M.state.timer then
    return -- Already running
  end

  -- Get current buffer
  M.state.bufnr = vim.api.nvim_get_current_buf()
  M.state.frame_idx = 1

  -- Create timer for animation
  M.state.timer = vim.loop.new_timer()
  
  M.state.timer:start(
    0,
    M.config.interval,
    vim.schedule_wrap(function()
      M.update_spinner()
    end)
  )
end

-- Update spinner frame
function M.update_spinner()
  if not M.state.bufnr or not vim.api.nvim_buf_is_valid(M.state.bufnr) then
    M.stop()
    return
  end

  -- Get current cursor position
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1 -- 0-indexed

  -- Clear previous extmark if it exists
  if M.state.extmark_id then
    pcall(vim.api.nvim_buf_del_extmark, M.state.bufnr, M.state.namespace, M.state.extmark_id)
  end

  -- Create virtual line with spinner
  local frame = M.config.frames[M.state.frame_idx]
  local text = string.format("%s CodeCompanion is thinking...", frame)

  M.state.extmark_id = vim.api.nvim_buf_set_extmark(M.state.bufnr, M.state.namespace, row, 0, {
    virt_lines = { { { text, M.config.hl_group } } },
    virt_lines_above = false,
  })

  -- Update frame index
  M.state.frame_idx = M.state.frame_idx % #M.config.frames + 1
end

-- Stop the spinner
function M.stop()
  if M.state.timer then
    M.state.timer:stop()
    M.state.timer:close()
    M.state.timer = nil
  end

  -- Clear extmark
  if M.state.bufnr and vim.api.nvim_buf_is_valid(M.state.bufnr) and M.state.extmark_id then
    pcall(vim.api.nvim_buf_del_extmark, M.state.bufnr, M.state.namespace, M.state.extmark_id)
  end

  M.state.extmark_id = nil
  M.state.bufnr = nil
  M.state.frame_idx = 1
end

-- Setup autocommands to hook into CodeCompanion events
function M.setup()
  local group = vim.api.nvim_create_augroup("CodeCompanionSpinner", { clear = true })
  
  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(event)
      if event.match == "CodeCompanionRequestStarted" then
        M.start()
      elseif event.match == "CodeCompanionRequestFinished" then
        M.stop()
      end
    end,
  })
end

return M
