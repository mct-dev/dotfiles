-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ai_refactor = require("ai_refactor")

vim.api.nvim_create_user_command("AIRefactor", function(opts)
  ai_refactor.run(opts.args ~= "" and opts.args or nil)
end, {
  desc = "Run ai-refactor on current file",
  nargs = "?",
})

local mappings = {
  { "<leader>g", "g", "AI: gpt-5.1 (medium)" },
  { "<leader>G", "gpt-5-1-codex-max", "AI: gpt-5-1-codex-max" },
  { "<leader>i", "i", "AI: gemini-3-pro" },
  { "<leader>I", "I", "AI: gemini-3-fast/high" },
  { "<leader>s", "s", "AI: sonnet-4.5 (medium)" },
  { "<leader>S", "S", "AI: sonnet-4.5 (high)" },
}

for _, map in ipairs(mappings) do
  vim.keymap.set("n", map[1], function()
    ai_refactor.run(map[2])
  end, { desc = map[3] })
end
