-- VSCode-Neovim specific configuration
-- This file bridges LazyVim keybindings to VSCode/Cursor commands

-- Check if running in VSCode
if vim.g.vscode then
  -- Leader key (LazyVim uses space)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- VSCode action helper
  local vscode = require('vscode-neovim')

  -- File operations (Telescope replacements)
  vim.keymap.set('n', '<leader>ff', function() vscode.action('workbench.action.quickOpen') end)
  vim.keymap.set('n', '<leader>fr', function() vscode.action('workbench.action.openRecent') end)
  vim.keymap.set('n', '<leader>fg', function() vscode.action('workbench.action.findInFiles') end)
  vim.keymap.set('n', '<leader>/', function() vscode.action('workbench.action.findInFiles') end)
  vim.keymap.set('n', '<leader>fb', function() vscode.action('workbench.action.showAllEditors') end)
  vim.keymap.set('n', '<leader><leader>', function() vscode.action('workbench.action.quickOpen') end)

  -- Buffer/tab navigation
  vim.keymap.set('n', '<S-h>', function() vscode.action('workbench.action.previousEditor') end)
  vim.keymap.set('n', '<S-l>', function() vscode.action('workbench.action.nextEditor') end)
  vim.keymap.set('n', '<leader>bd', function() vscode.action('workbench.action.closeActiveEditor') end)
  vim.keymap.set('n', '<leader>bb', function() vscode.action('workbench.action.showAllEditors') end)

  -- Window navigation
  vim.keymap.set('n', '<C-h>', function() vscode.action('workbench.action.focusLeftGroup') end)
  vim.keymap.set('n', '<C-l>', function() vscode.action('workbench.action.focusRightGroup') end)
  vim.keymap.set('n', '<C-j>', function() vscode.action('workbench.action.focusBelowGroup') end)
  vim.keymap.set('n', '<C-k>', function() vscode.action('workbench.action.focusAboveGroup') end)

  -- Window splits
  vim.keymap.set('n', '<leader>ws', function() vscode.action('workbench.action.splitEditorDown') end)
  vim.keymap.set('n', '<leader>wv', function() vscode.action('workbench.action.splitEditorRight') end)
  vim.keymap.set('n', '<leader>wd', function() vscode.action('workbench.action.closeActiveEditor') end)
  vim.keymap.set('n', '<leader>-', function() vscode.action('workbench.action.splitEditorDown') end)
  vim.keymap.set('n', '<leader>|', function() vscode.action('workbench.action.splitEditorRight') end)

  -- Code actions (LSP)
  vim.keymap.set('n', '<leader>ca', function() vscode.action('editor.action.quickFix') end)
  vim.keymap.set('n', '<leader>cr', function() vscode.action('editor.action.rename') end)
  vim.keymap.set('n', '<leader>cf', function() vscode.action('editor.action.formatDocument') end)
  vim.keymap.set('n', 'K', function() vscode.action('editor.action.showHover') end)

  -- LSP navigation
  vim.keymap.set('n', 'gd', function() vscode.action('editor.action.revealDefinition') end)
  vim.keymap.set('n', 'gD', function() vscode.action('editor.action.revealDeclaration') end)
  vim.keymap.set('n', 'gr', function() vscode.action('editor.action.goToReferences') end)
  vim.keymap.set('n', 'gI', function() vscode.action('editor.action.goToImplementation') end)
  vim.keymap.set('n', 'gy', function() vscode.action('editor.action.goToTypeDefinition') end)

  -- Diagnostic navigation
  vim.keymap.set('n', ']d', function() vscode.action('editor.action.marker.next') end)
  vim.keymap.set('n', '[d', function() vscode.action('editor.action.marker.prev') end)
  vim.keymap.set('n', '<leader>xx', function() vscode.action('workbench.actions.view.problems') end)
  vim.keymap.set('n', '<leader>xl', function() vscode.action('workbench.actions.view.problems') end)

  -- Search
  vim.keymap.set('n', '<leader>sg', function() vscode.action('workbench.action.findInFiles') end)
  vim.keymap.set('n', '<leader>ss', function() vscode.action('workbench.action.gotoSymbol') end)
  vim.keymap.set('n', '<leader>sS', function() vscode.action('workbench.action.showAllSymbols') end)

  -- Git (LazyVim style)
  vim.keymap.set('n', '<leader>gg', function() vscode.action('workbench.view.scm') end)
  vim.keymap.set('n', '<leader>gb', function() vscode.action('gitlens.toggleLineBlame') end)
  vim.keymap.set('n', ']h', function() vscode.action('workbench.action.editor.nextChange') end)
  vim.keymap.set('n', '[h', function() vscode.action('workbench.action.editor.previousChange') end)

  -- Terminal
  vim.keymap.set('n', '<leader>ft', function() vscode.action('workbench.action.terminal.toggleTerminal') end)
  vim.keymap.set('n', '<C-/>', function() vscode.action('workbench.action.terminal.toggleTerminal') end)

  -- Comments (LazyVim style)
  vim.keymap.set('n', 'gcc', function() vscode.action('editor.action.commentLine') end)
  vim.keymap.set('v', 'gc', function() vscode.action('editor.action.commentLine') end)

  -- Better indenting
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')

  -- Move lines up/down
  vim.keymap.set('n', '<A-j>', function() vscode.action('editor.action.moveLinesDownAction') end)
  vim.keymap.set('n', '<A-k>', function() vscode.action('editor.action.moveLinesUpAction') end)
  vim.keymap.set('v', 'J', function() vscode.action('editor.action.moveLinesDownAction') end)
  vim.keymap.set('v', 'K', function() vscode.action('editor.action.moveLinesUpAction') end)

  -- Save file
  vim.keymap.set('n', '<leader>w', function() vscode.action('workbench.action.files.save') end)

  -- Quit
  vim.keymap.set('n', '<leader>q', function() vscode.action('workbench.action.closeActiveEditor') end)
  vim.keymap.set('n', '<leader>qa', function() vscode.action('workbench.action.closeAllEditors') end)

  -- Notifications
  vim.keymap.set('n', '<leader>un', function() vscode.action('notifications.clearAll') end)

  -- Zen mode
  vim.keymap.set('n', '<leader>uz', function() vscode.action('workbench.action.toggleZenMode') end)

  -- Command palette
  vim.keymap.set('n', '<leader>:', function() vscode.action('workbench.action.showCommands') end)

  -- Clipboard
  vim.opt.clipboard = 'unnamedplus'

  -- Search
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.hlsearch = true
  vim.opt.incsearch = true

  -- Clear search highlight
  vim.keymap.set('n', '<Esc>', '<cmd>nohl<CR>')
  vim.keymap.set('n', '<leader>ur', '<cmd>nohl<CR>')

else
  -- Load regular LazyVim config when not in VSCode
  require("config.lazy")
end
