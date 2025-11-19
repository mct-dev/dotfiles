-- Check if running inside VSCode
if vim.g.vscode then
  -- VSCode Neovim specific configuration
  require("config.vscode")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
