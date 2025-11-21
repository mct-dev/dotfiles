# Dotfiles Highlights

- **AI refactor in Neovim**: trailing comment prompt + `<leader>g/G/i/I/s/S` to run the vendored `ai-refactor` (Taelin-style) with gpt-5.1, gpt-5-1-codex-max, Gemini 3, or Sonnet 4.5. Edits apply automatically; output streams in a bottom split.
- **Install helper**: run `ai_refactor_install` (from `.zshrc`) to install bun deps in `~/.config/ai-scripts` and create `~/.local/bin/ai-refactor`.
- **Tokens**: place API keys in `~/.config/{openai,anthropic,google}.token` (and `xai.token` if needed) for the models above.
- **Portability**: `ai-scripts` lives in `~/.config/ai-scripts` under chezmoi; the shim and Neovim Lua module are tracked so new machines work after `chezmoi apply` + `ai_refactor_install`.
