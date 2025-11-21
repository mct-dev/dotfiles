local M = {}

local model_choices = {
  { key = "g", label = "g  – gpt-5.1 (medium)", alias = "g" },
  { key = "G", label = "G  – gpt-5-1-codex", alias = "gpt-5-1-codex" },
  { key = "i", label = "i  – gemini-3-pro", alias = "i" },
  { key = "I", label = "I  – gemini-3-fast", alias = "I" },
  { key = "s", label = "s  – sonnet-4.5 (medium)", alias = "s" },
  { key = "S", label = "S  – sonnet-4.5 (high)", alias = "S" },
}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "ai-refactor" })
end

local function project_root(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":p:h")
  local git_dir = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
  if git_dir and git_dir ~= "" then
    return git_dir
  end
  return dir
end

local function ensure_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    notify("Current buffer has no file name.", vim.log.levels.ERROR)
    return nil
  end
  return file
end

local function select_model(cb)
  vim.ui.select(model_choices, {
    prompt = "Pick a model",
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if not choice then
      return
    end
    cb(choice.alias)
  end)
end

local function open_output_window()
  vim.cmd("tabnew")
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, "AI Refactor Output")
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  -- keep buffer alive if you switch away; leave it unlisted but not wiped
  vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  vim.bo[buf].syntax = "markdown"
  pcall(function()
    -- treesitter gives better fenced code styling if parser is installed
    if vim.treesitter and vim.treesitter.start then
      vim.treesitter.start(buf, "markdown")
    end
  end)
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true, silent = true })
  return buf, win
end

local function runner_cmd()
  return vim.g.ai_refactor_cmd or vim.fn.expand("~/.local/bin/ai-refactor")
end

local function strip_ansi(line)
  return line:gsub("\27%[[0-9;]*[mK]", "")
end

local function append_data(buf, data, win)
  if not data or #data == 0 then
    return
  end
  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    local lines = {}
    for _, line in ipairs(data) do
      local clean = strip_ansi(line)
      -- keep empty lines to preserve spacing
      table.insert(lines, clean)
    end
    if #lines > 0 then
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
      if win and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
        pcall(vim.api.nvim_win_set_cursor, win, { vim.api.nvim_buf_line_count(buf), 0 })
      end
    end
  end)
end

function M.run(alias)
  local file = ensure_file()
  if not file then
    return
  end

  if not alias or alias == "" then
    return select_model(M.run)
  end

  vim.cmd("write")
  local root = project_root(file)
  local cmd = { runner_cmd(), file, alias }
  local buf, win = open_output_window()

  local job = vim.fn.jobstart(cmd, {
    cwd = root,
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data, _)
      append_data(buf, data, win)
    end,
    on_stderr = function(_, data, _)
      append_data(buf, data, win)
    end,
    on_exit = function(_, code, _)
      vim.schedule(function()
        if code == 0 then
          vim.cmd("checktime")
        else
          notify(string.format("ai-refactor exited with %d", code), vim.log.levels.ERROR)
        end
      end)
    end,
  })

  if job <= 0 then
    notify("Failed to start ai-refactor job", vim.log.levels.ERROR)
  end
end

return M
