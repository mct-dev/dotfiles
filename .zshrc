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

. /Users/miketobias/git/rupa/z/z.sh

plugins=(
  aws
  docker
  docker-compose
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias l="exa -la"
alias ls="exa"
alias tf="terraform"
alias k="kubectl"
