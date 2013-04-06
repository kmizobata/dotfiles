##========#
## Alias ##
#========##
setopt complete_aliases # aliased ls needs if file/dir completions work

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -lh"
alias lla="ls -lah"

alias du="du -h"
alias df="df -h"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias mkdir='mkdir -v'

alias ln='ln -v'

alias su="su -l"

alias chmod='chmod -v'
alias chown='chown -v'

alias where="command -v"
alias j="jobs -l"
