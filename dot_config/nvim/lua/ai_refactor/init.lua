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

local function guess_lang_from_path(pathname)
  local ext = pathname:match("%.([%w%d_%-]+)$")
  if not ext then
    return nil
  end
  local map = {
    ts = "typescript",
    tsx = "typescriptreact",
    js = "javascript",
    jsx = "javascriptreact",
    mjs = "javascript",
    cjs = "javascript",
    json = "json",
    lua = "lua",
    py = "python",
    rs = "rust",
    go = "go",
    rb = "ruby",
    sh = "bash",
    bash = "bash",
    zsh = "bash",
    css = "css",
    scss = "scss",
    md = "markdown",
    html = "html",
    htm = "html",
    cpp = "cpp",
    cc = "cpp",
    cxx = "cpp",
    c = "c",
    h = "c",
    hpp = "cpp",
    java = "java",
    kt = "kotlin",
    cs = "csharp",
    php = "php",
    swift = "swift",
    m = "objective-c",
    mm = "objective-cpp",
    sql = "sql",
    yaml = "yaml",
    yml = "yaml",
    toml = "toml",
    xml = "xml",
    env = "dotenv",
  }
  return map[ext]
end

local function append_data(buf, data, win, state)
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
      -- Stream-aware tag handling to make <write/> and <patch/> readable
      if state.in_tag then
        if clean:match("^%s*</%s*write%s*>%s*$") or clean:match("^%s*</%s*patch%s*>%s*$") then
          table.insert(lines, "```")
          state.in_tag = false
          state.lang = nil
        else
          table.insert(lines, clean)
        end
      else
        local write_file = clean:match("^%s*<%s*write%s+file=[\"']?([^\"'>]+)[\"']?%s*>%s*$")
        local patch_id = clean:match("^%s*<%s*patch%s+id=[\"']?(%d+)[\"']?%s*>%s*$")
        local delete_file = clean:match("^%s*<%s*delete%s+file=[\"']?([^\"'>]+)/%s*>%s*$")

        if write_file then
          local lang = guess_lang_from_path(write_file)
          table.insert(lines, string.format("**write %s**", write_file))
          table.insert(lines, "```" .. (lang or ""))
          state.in_tag = true
          state.lang = lang
        elseif patch_id then
          table.insert(lines, string.format("**patch id=%s**", patch_id))
          table.insert(lines, "```")
          state.in_tag = true
          state.lang = nil
        elseif delete_file then
          table.insert(lines, string.format("**delete %s**", delete_file))
        else
          table.insert(lines, clean)
        end
      end
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
  local state = { in_tag = false, lang = nil }

  local job = vim.fn.jobstart(cmd, {
    cwd = root,
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data, _)
      append_data(buf, data, win, state)
    end,
    on_stderr = function(_, data, _)
      append_data(buf, data, win, state)
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
