# common/.profile.d/99-alias.sh
alias s="\$(which ssh)"
alias quit='exit'
alias cr='reset; clear'
alias a=ag
alias n=noglob
alias l=ls
alias L='ls -dal'
alias cleandir="find . -type f \( -name '*~' -o -name '#*#' -o -name '.*~' -o -name '.#*#' -o -name 'core' -o -name 'dead.letter*' \) | grep -v auto-save-list | xargs -t rm"
which less > /dev/null 2>&1
[ $? = 0 ] && alias T='less -f +F' || alias T='tail -f'
