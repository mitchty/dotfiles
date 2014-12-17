;;-*-mode: emacs-lisp; coding: utf-8;-*-

(autoload 'cperl-mode "cperl-mode" "mode for perl scripts" t)

(add-to-list 'auto-mode-alist '("\\.[Pp][LlMm]\\'" . cperl-mode))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (load "mode-defaults")
             (smartparens-mode)
             (flycheck-mode)
             ))
