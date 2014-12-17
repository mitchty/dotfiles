;;-*-mode: emacs-lisp; coding: utf-8;-*-

(autoload 'sh--mode "sh-mode" "mode for shell stuff" t)

(add-to-list 'auto-mode-alist '("\\.sh$\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.[zk]sh$\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash$\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\[.].*shrc$\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("sourceme$\\'" . sh-mode))

(add-hook 'sh-mode-hook
          '(lambda ()
             (load "mode-defaults")
             (smartparens-mode)
             (flycheck-mode)
             (setq-default indent-tabs-mode nil)
             (setq sh-basic-offset 2 sh-indentation 4
                   sh-indent-for-case-label 0 sh-indent-for-case-alt '+)))
