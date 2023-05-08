alias timestamp='date +"%s"'

# convert from utf-8 to the full character name
alias toname='uconv -x "hex-any; any-name"'

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias ruler='seq -s "" -f "%4.0f|" 5 5'

# 2016-08-03 Simplifies piping command output to the clipboard, like
# ls | clipboard.
alias clipboard='xclip -sel clip'

