# emacs/.profile.d/99-alias-emacs.sh
alias e=emacs
alias de=emacs --debug-init -nw
alias ec=emacsclient
alias ect=emacsclient -t
alias oec=emacsclient -n -c
alias stope=emacsclient -t -e "(save-buffers-kill-emacs)(kill-emacs)"
alias kille=emacsclient -e "(kill-emacs)"
