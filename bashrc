# 2018-04-06: From
# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history/18443#18443
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
# This doesn't seem to work correctly. The history gets extra copies of the
# first command from this shell.
#PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
#PROMPT_COMMAND="history -a; history -n"
# stores multiline shell commands as one line
#shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Disable profiling.
#set +x
# exec 2>&3 3>&-

export EDITOR='vi'
# Added 2018-07-31 to prevent ctrl-s stopping vim per
# https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#export HISTCONTROL=ignoreboth:erasedups
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="%F %T "

# append to the history file, don't overwrite it
#shopt -s histappend

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
