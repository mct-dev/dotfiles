-- VSCode Neovim specific configuration
-- This file is loaded when Neovim is running inside VSCode

local vscode = require("vscode-neovim")

-- Set leader keys (same as regular config)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic options that work in VSCode
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive when uppercase present
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Incremental search

-- Fold options - prevent auto-unfold on cursor movement
-- Clear all foldopen options so folds never auto-expand
vim.opt.foldopen = ""

-- Preserve LazyVim-style keymaps using VSCode commands
local keymap = vim.keymap.set

-- Note: With foldopen settings configured, folds should stay closed during navigation
-- If folds still auto-open, use zj/zk to navigate between folds

-- File navigation (mimicking telescope)
keymap("n", "<leader>ff", function()
  vscode.call("workbench.action.quickOpen")
end, { desc = "Find Files" })

keymap("n", "<leader>fg", function()
  vscode.call("workbench.action.findInFiles")
end, { desc = "Find in Files (Grep)" })

keymap("n", "<leader>fb", function()
  vscode.call("workbench.action.showAllEditors")
end, { desc = "Find Buffers" })

keymap("n", "<leader>fr", function()
  vscode.call("workbench.action.openRecent")
end, { desc = "Recent Files" })

-- Code navigation
keymap("n", "gd", function()
  vscode.call("editor.action.revealDefinition")
end, { desc = "Go to Definition" })

keymap("n", "gD", function()
  vscode.call("editor.action.revealDeclaration")
end, { desc = "Go to Declaration" })

keymap("n", "gr", function()
  vscode.call("editor.action.goToReferences")
end, { desc = "Go to References" })

keymap("n", "gi", function()
  vscode.call("editor.action.goToImplementation")
end, { desc = "Go to Implementation" })

keymap("n", "gt", function()
  vscode.call("editor.action.goToTypeDefinition")
end, { desc = "Go to Type Definition" })

-- LSP
keymap("n", "<leader>ca", function()
  vscode.call("editor.action.quickFix")
end, { desc = "Code Actions" })

keymap("n", "<leader>cr", function()
  vscode.call("editor.action.rename")
end, { desc = "Rename Symbol" })

keymap("n", "K", function()
  vscode.call("editor.action.showHover")
end, { desc = "Show Hover" })

keymap("n", "<leader>cf", function()
  vscode.call("editor.action.formatDocument")
end, { desc = "Format Document" })

-- Diagnostics
keymap("n", "<leader>cd", function()
  vscode.call("editor.action.marker.nextInFiles")
end, { desc = "Next Diagnostic" })

keymap("n", "[d", function()
  vscode.call("editor.action.marker.prevInFiles")
end, { desc = "Previous Diagnostic" })

keymap("n", "]d", function()
  vscode.call("editor.action.marker.nextInFiles")
end, { desc = "Next Diagnostic" })

-- Window management
keymap("n", "<leader>w", function()
  vscode.call("workbench.action.focusNextGroup")
end, { desc = "Next Window" })

keymap("n", "<leader>wd", function()
  vscode.call("workbench.action.closeActiveEditor")
end, { desc = "Close Window" })

keymap("n", "<leader>ww", function()
  vscode.call("workbench.action.focusNextGroup")
end, { desc = "Next Window" })

keymap("n", "<leader>ws", function()
  vscode.call("workbench.action.splitEditorDown")
end, { desc = "Split Window Below" })

keymap("n", "<leader>wv", function()
  vscode.call("workbench.action.splitEditorRight")
end, { desc = "Split Window Right" })

-- Buffer/Tab management
keymap("n", "<leader>,", function()
  vscode.call("workbench.action.showAllEditorsByMostRecentlyUsed")
end, { desc = "Switch Buffer" })

keymap("n", "<leader>bd", function()
  vscode.call("workbench.action.closeActiveEditor")
end, { desc = "Delete Buffer" })

keymap("n", "<leader>bo", function()
  vscode.call("workbench.action.closeOtherEditors")
end, { desc = "Delete Other Buffers" })

keymap("n", "<S-h>", function()
  vscode.call("workbench.action.previousEditor")
end, { desc = "Previous Buffer" })

keymap("n", "<S-l>", function()
  vscode.call("workbench.action.nextEditor")
end, { desc = "Next Buffer" })

-- Git
keymap("n", "<leader>gg", function()
  vscode.call("workbench.view.scm")
end, { desc = "Git Status" })

keymap("n", "<leader>gb", function()
  vscode.call("gitlens.toggleLineBlame")
end, { desc = "Toggle Git Blame" })

-- Terminal
keymap("n", "<leader>ft", function()
  vscode.call("workbench.action.terminal.toggleTerminal")
end, { desc = "Toggle Terminal" })

keymap("n", "<c-/>", function()
  vscode.call("workbench.action.terminal.toggleTerminal")
end, { desc = "Toggle Terminal" })

-- Explorer
keymap("n", "<leader>e", function()
  vscode.call("workbench.view.explorer")
end, { desc = "Explorer" })

keymap("n", "<leader>E", function()
  vscode.call("workbench.files.action.focusFilesExplorer")
end, { desc = "Focus Explorer" })

-- Search
keymap("n", "<leader>sg", function()
  vscode.call("workbench.action.findInFiles")
end, { desc = "Search Grep" })

keymap("n", "<leader>sw", function()
  vscode.call("workbench.action.findInFiles")
end, { desc = "Search Word" })

-- File picker (matches LazyVim behavior)
keymap("n", "<leader><space>", function()
  vscode.call("workbench.action.quickOpen")
end, { desc = "Find Files" })

-- Command palette
keymap("n", "<leader>:", function()
  vscode.call("workbench.action.showCommands")
end, { desc = "Command Palette" })

-- Clear search highlight
keymap("n", "<Esc>", function()
  vscode.call("search.action.clearSearchResults")
  vim.cmd("noh")
end, { desc = "Clear Search" })

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Paste without overwriting register
keymap("x", "<leader>p", '"_dP')

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", '"_d')

-- Comments (handled by VSCode)
keymap("n", "gcc", function()
  vscode.call("editor.action.commentLine")
end, { desc = "Comment Line" })

keymap("v", "gc", function()
  vscode.call("editor.action.commentLine")
end, { desc = "Comment Selection" })

-- Zen mode / Focus mode
keymap("n", "<leader>z", function()
  vscode.call("workbench.action.toggleZenMode")
end, { desc = "Toggle Zen Mode" })

-- Folding commands (map Vim fold commands to VSCode folding)
keymap("n", "za", function()
  vscode.call("editor.toggleFold")
end, { desc = "Toggle Fold" })

keymap("n", "zo", function()
  vscode.call("editor.unfold")
end, { desc = "Open Fold" })

keymap("n", "zc", function()
  vscode.call("editor.fold")
end, { desc = "Close Fold" })

keymap("n", "zO", function()
  vscode.call("editor.unfoldRecursively")
end, { desc = "Open Fold Recursively" })

keymap("n", "zC", function()
  vscode.call("editor.foldRecursively")
end, { desc = "Close Fold Recursively" })

keymap("n", "zM", function()
  vscode.call("editor.foldAll")
end, { desc = "Close All Folds" })

keymap("n", "zR", function()
  vscode.call("editor.unfoldAll")
end, { desc = "Open All Folds" })

keymap("n", "zj", function()
  vscode.call("editor.gotoNextFold")
end, { desc = "Next Fold" })

keymap("n", "zk", function()
  vscode.call("editor.gotoPreviousFold")
end, { desc = "Previous Fold" })
