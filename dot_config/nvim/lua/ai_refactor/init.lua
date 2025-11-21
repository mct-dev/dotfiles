local M = {}

local model_choices = {
  { key = "g", label = "g  – gpt-5.1 (medium)", alias = "g" },
  { key = "G", label = "G  – gpt-5-1-codex-max", alias = "gpt-5-1-codex-max" },
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

local function open_terminal_window()
  local height = math.max(10, math.floor(vim.o.lines * 0.25))
  vim.cmd(string.format("botright %dsplit", height))
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_option(buf, "filetype", "ai-refactor")
  return buf
end

local function runner_cmd()
  return vim.g.ai_refactor_cmd or vim.fn.expand("~/.local/bin/ai-refactor")
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
  local buf = open_terminal_window()

  vim.fn.termopen(cmd, {
    cwd = root,
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

  vim.cmd("startinsert")
end

return M
