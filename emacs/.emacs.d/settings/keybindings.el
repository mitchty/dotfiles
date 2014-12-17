;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; show what is being typed quicker
(custom-set-variables '(echo-keystrokes 0.1))

;; Let shift+arrow keys change panes
(require 'windmove)
(windmove-default-keybindings)

;; Ok, so make it possible to use option+char on osx to type accented
;; chars in cocoa emacs.
;; Also makes command is meta.
(when window-system
  (cond (osx-p
         (setq mac-option-modifier 'none)
         (setq mac-command-modifier 'meta))))
