;;-*-mode: Emacs-Lisp; coding: utf-8;-*-

(add-to-list 'auto-mode-alist '("\\.org\>" . org-mode))

(add-hook 'org-mode-hook
          (lambda ()
            (ispell-minor-mode)
            (visual-line-mode)
            (hl-line-mode)
            (delete '("\\.pdf\\'" . default) org-file-apps)
            (if osx-p
                (add-to-list 'org-file-apps '("\\.pdf\\'" . "open %s"))
              (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s")))
            ))
