;;-*-mode: emacs-lisp; coding: utf-8;-*-

(add-hook 'python-mode-hook
          '(lambda ()
             (load "mode-defaults")
             (smartparens-mode)
             (flycheck-mode)
             (flycheck-select-checker 'python-flake8)
             ))
