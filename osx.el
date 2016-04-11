;;-*-mode: emacs-lisp; coding: utf-8;-*-
;; All these variables control what/how readme.org gets tangled
;; into dotfiles. Off by default set to t to turn them on as
;; needed.

;; OS types
(setq bsd-p nil)
(setq linux-p nil)
(setq osx-p t)

;; Optional things
(setq nix-p t)
(setq tmux-p t)
(setq git-p t)
(setq emacs-p t)
(setq vim-p nil)
(setq zsh-p t)
(setq mosh-p t)
(setq x-p t)

;; Language specific
(setq haskell-p t)
(setq perl-p t)
