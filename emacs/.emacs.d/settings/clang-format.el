;;-*-mode: emacs-lisp; coding: utf-8;-*-

(when osx-p
  (setq exec-path
        (append exec-path
                '("/Users/mitch/homebrew/Cellar/llvm/3.4/bin"))))
(when linux-p
  (setq exec-path (append '("/home/mitch/local/bin") exec-path)))

(load "~/.emacs.d/misc/clang-format.el")
(global-set-key [C-M-tab] 'clang-format-region)
