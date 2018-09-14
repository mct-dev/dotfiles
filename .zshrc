##### ALIASES
alias cdwork="cd /cygdrive/c/work/"
alias cdmt="cd /cygdrive/c/Users/MichaelT/"
# git aliases
alias gst="git status"
alias gb="git branch"
alias gl="git log --oneline"
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gd="git diff"
alias gr="git remote"
alias gra="git remote add"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gla="!git config -l | grep alias | cut -c 7-"

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vimconfig="vim ~/.vimrc"
alias docker-rm-dangling='docker rmi $(docker images -f "dangling=true" -q)'
# alias logout='gnome-session-quit'

##### EXPORTS
# Path to your oh-my-zsh installation.
export ZSH=/home/MichaelT/.oh-my-zsh
# Other exports
# export TERM="xterm-256color"

export DEFAULT_USER="$USER"
export HOSTFILE="/cygdrive/c/Windows/System32/drivers/etc/hosts"

###### THEMES
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=("ys" "juanghurtado" "robbyrussell" "agnoster" "af-magic" "arrow" "fino")

####### RANDOM BASE CONFIG SETTINGS
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
#
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


###### PLUGINS
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
# docker 
 git 
 zsh-autosuggestions
# git-extras 
# npm
)

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


######## MINE ##########
source $ZSH/oh-my-zsh.sh
set statusline+=%F

if [ "$TMUX" = "" ]; then
    tmux new-session \;
fi

# Fix dir colors in windows
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
# LS_COLORS='' export LS_COLORS

###### PATH
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/cygdrive/c/Users/MichaelT/AppData/Roaming/npm

# speed up cd into git repo when using ohmyzsh themes
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# set dircolors
eval `dircolors ~/.dir_colors`
