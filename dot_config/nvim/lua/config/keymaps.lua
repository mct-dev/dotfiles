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
  { "g", "g", "AI: gpt-5.1 (medium)" },
  { "G", "gpt-5-1-codex-max", "AI: gpt-5-1-codex-max" },
  { "i", "i", "AI: gemini-3-pro" },
  { "I", "I", "AI: gemini-3-fast/high" },
  { "s", "s", "AI: sonnet-4.5 (medium)" },
  { "S", "S", "AI: sonnet-4.5 (high)" },
}

-- Hook into <leader>a ai menu: modal submenu under <leader>a?,
-- and fallback direct mappings under <leader>a<key>.
for _, map in ipairs(mappings) do
  vim.keymap.set("n", "<leader>a" .. map[1], function()
    ai_refactor.run(map[2])
  end, { desc = map[3] })
end

-- Optional: a small picker under <leader>a<space>
vim.keymap.set("n", "<leader>a ", function()
  ai_refactor.run(nil)
end, { desc = "AI: pick model (Refactor)" })
