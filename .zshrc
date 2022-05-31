# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

export ZSH="$HOME/.oh-my-zsh"

source $HOME/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle wbingli/zsh-wakatime
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply


plugins=(
  aws
  docker
  docker-compose
)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
alias python=python3
alias lg="lazygit"
alias gt="git town"
alias l="exa -la"
alias ls="exa"
alias tf="terraform"
alias k="kubectl"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
