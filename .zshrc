# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#  fi

export EDITOR=nvim

# pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

export ZSH="$HOME/.oh-my-zsh"

source $HOME/antigen.zsh
# antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# $(brew --prefix)/etc/profile.d/z.sh
. /Users/miketobias/github.com/rupa/z/z.sh


plugins=(
   git
   rust
   aws
   docker
#   docker-compose
)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
# alias vim="nvim"
alias python=python3
alias lg="lazygit"
alias gt="git town"
alias l="exa -la"
alias ls="exa"
alias tf="terraform"
alias k="kubectl"
alias gl-releasable="/usr/local/bin/git-log-releasable.sh"
alias myip="dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com"

# golang
export GOPATH="$HOME/go"
export PATH="/Users/miketobias/.local/bin:$GOPATH/bin:$PATH"

# bun completions
[ -s "/Users/miketobias/.bun/_bun" ] && source "/Users/miketobias/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "/Users/miketobias/.ghcup/env" ] && source "/Users/miketobias/.ghcup/env" # ghcup-env

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# rvm. Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# postgres
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# source /Users/miketobias/.config/op/plugins.sh

# add ffmpeg to path
export PATH="/opt/homebrew/bin:$PATH"

# add flutter to path
export PATH="$PATH:/Users/miketobias/flutter/bin"

# for mac assistant repo
APPLE_ID=mike.tobias@timebyping.com

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/miketobias/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# deno
. "/Users/miketobias/.deno/env"

# Added by Windsurf
export PATH="/Users/miketobias/.codeium/windsurf/bin:$PATH"

# Task Master aliases added on 4/18/2025
alias tm='task-master'
alias taskmaster='task-master'

# secrets
source $HOME/.zshrc_env_vars
