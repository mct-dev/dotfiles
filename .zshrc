# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/mike/.oh-my-zsh
# Other exports
export TERM="xterm-256color"

## powerlevel9k
export DEFAULT_USER="$USER"
# POWERLEVEL9K_MODE='awesome-fontconfig'
# POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_MODE='nerdfont-fontconfig'
POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_IP_INTERFACE=wlo1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_middle
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh context dir dir_writable vcs go_version)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status background_jobs load battery)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs load battery public_ip)
# if [[ "$OSTYPE" == darwin* ]]; then
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv status background_jobs)
# else
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs)
# fi
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B4"
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uE0B6"
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_BACKGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
## powerlevel9k

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "juanghurtado" "robbyrussell" "agnoster" "af-magic" "arrow" "fino")

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
docker git git-extras z warhol ubuntu nyan npm ruby python
)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias docker-rm-dangling='docker rmi $(docker images -f "dangling=true" -q)'
alias logout='gnome-session-quit'

# JS STUFF
# alias node to babel-node for ES6
# alias node="babel-node"

######## MINE ##########
source $ZSH/oh-my-zsh.sh

if [[ -x /usr/bin/grc ]]; then
  if [ -x /bin/ls ]; then
    function ls() {
      \grc --colour=auto unbuffer /bin/ls --color=tty "$@"
    }
  fi
  if [ -x /usr/sbin/ip ]; then
    function ip() {
      \grc --colour=auto /usr/sbin/ip "$@"
    }
  fi
  if [ -x /usr/sbin/ss ]; then
    function ss() {
      \grc --colour=auto /usr/sbin/ss "$@"
    }
  fi
  if [ -x /usr/bin/df ]; then
    function df() {
      \grc --colour=auto /usr/bin/df "$@"
    }
  fi
  if [ -x /usr/bin/du ]; then
    function du() {
      \grc --colour=auto /usr/bin/du "$@"
    }
  fi
  if [ -x /usr/bin/systemctl ]; then
    function systemctl() {
      \grc --colour=auto /usr/bin/systemctl "$@"
    }
  fi
  if [ -x /usr/sbin/sysctl ]; then
    function sysctl() {
      \grc --colour=auto /usr/sbin/sysctl "$@"
    }
  fi
  if [ -x /usr/bin/env ]; then
    function env() {
      \grc --colour=auto /usr/bin/env "$@"
    }
  fi
  if [ -x /usr/bin/lsof ]; then
    function lsof() {
      \grc --colour=auto /usr/bin/lsof "$@"
    }
  fi
fi

###-tns-completion-start-###
if [ -f /home/mike/.tnsrc ]; then 
    source /home/mike/.tnsrc 
fi
###-tns-completion-end-###

# END
if [ "$TMUX" = "" ]; then
    tmux new-session \;
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
