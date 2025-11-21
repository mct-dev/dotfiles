# ai-refactor installer and auto-setup

ai_refactor_install() {
  local root="${HOME}/.config/ai-scripts"
  if [ ! -d "${root}" ]; then
    echo "ai-scripts not found at ${root}. Clone or apply chezmoi first." >&2
    return 1
  fi

  if ! command -v bun >/dev/null 2>&1; then
    echo "bun is required. Install bun (https://bun.sh) and re-run." >&2
    return 1
  fi

  (cd "${root}" && bun install)

  mkdir -p "${HOME}/.local/bin"
  cat > "${HOME}/.local/bin/ai-refactor" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
ROOT="${HOME}/.config/ai-scripts"
if [ ! -d "${ROOT}" ]; then
  echo "ai-scripts not found at ${ROOT}. Did you clone or chezmoi apply your dotfiles?" >&2
  exit 1
fi
if ! command -v bun >/dev/null 2>&1; then
  echo "bun is required to run ai-refactor. Install bun and re-run." >&2
  exit 1
fi
# Run from current directory (your project), pointing bun at the vendored script.
exec bun "${ROOT}/Refactor.ts" "$@"
EOF
  chmod +x "${HOME}/.local/bin/ai-refactor"
  echo "ai-refactor installed. Ensure tokens exist at ~/.config/{openai,anthropic,google}.token"
}

if [ -z "${AI_REFACTOR_SKIP_AUTO:-}" ]; then
  if ! command -v bun >/dev/null 2>&1; then
    echo "bun is required for ai-refactor. Install bun (https://bun.sh) or set AI_REFACTOR_SKIP_AUTO=1 to skip." >&2
  elif [ ! -x "${HOME}/.local/bin/ai-refactor" ]; then
    ai_refactor_install
  fi
fi
