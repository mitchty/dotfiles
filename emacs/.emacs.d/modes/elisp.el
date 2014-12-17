;;-*-mode: emacs-lisp; coding: utf-8;-*-

(add-to-list 'auto-mode-alist '("\\.el" . emacs-lisp-mode))

(add-hook 'emacs-lisp-hook
          (lambda ()
            (hl-line-mode)
            (whitespace-mode)
            (flycheck-mode)
            (setq-default tab-width 2)
            (setq-default indent-tabs-mode nil)
            (define-key emacs-lisp-map
              "\C-x\C-e" 'pp-eval-last-sexp)
            (define-key emacs-lisp-map
              "\r" 'reindent-then-newline-and-indent)))
