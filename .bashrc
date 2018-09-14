alias l="ls -la --color"
alias la="ls -a --color"
alias ls="ls --color"
# alias reboot="shutdown /r"
alias md="mkdir"
alias ..="cd .."
alias cdwork="cd /cygdrive/c/work/"
alias cdmt="cd /cygdrive/c/Users/MichaelT/"

# a function to mimic the "man" (manual) feature of regular bash
m() {
	"$1" --help | less
}
alias man="m"
# alias cmd="/mnt/c/Windows/System32/cmd.exe $0"
alias bashrc="vim ~/.bashrc"

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


##### PROMPT SETTINGS #####

# check if $TERM matches regex of .*256.*
if [[ $TERM =~ .*256.* ]]; then

  # save original prompt
  DEFAULT=$PS1

  # user/comp name
  # PS1+="\[\033[1;31m\]\u@\h\[\033[1;34m\]"

  # date and time
  # PS1="\e[38;5;24m\]\D{%D} [\t]\[\033[0m\] | "

  # current working dir
  # PS1+="\[\033[32m\]\w\n"
  # PS1+="\e[38;5;30m\]\w\n"

  # file count and total file size
  # PS1+="\e[38;5;247m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \e[38;5;247m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')"

  # prompt
  # PS1+="\[\033[0m\] >> \[\033[0m\]"

fi

###########################

######  PATH ADDITIONS #####
PATH=$PATH:/c/Users/MichaelT/AppData/Roaming/npm/

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
