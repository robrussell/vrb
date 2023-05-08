# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="%F %T "
# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export EDITOR='vi'

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: ${PWD/\/google\/src\/cloud\/robrussell\//citc:}\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Added 2018-07-31 to prevent ctrl-s stopping vim per
# https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# rjr - custom colour prompt
RED="\[\e[0;31m\]"
YELLOW="\[\e[0;33m\]"
GREEN="\[\e[0;32m\]"

# git info on prompt, from http://railstips.org/blog/archives/2009/02/02/bedazzle-your-bash-prompt-with-git-info/
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

# last command success, adapted from https://makandracards.com/makandra/1090-customize-your-bash-prompt
function show_last_exit {
  if [ $? = 0 ]; then echo "${GREEN}✔"; else echo "${RED}✘"; fi
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# rjr - Added for previews with cd per https://github.com/junegunn/fzf 2022-10--14
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}
