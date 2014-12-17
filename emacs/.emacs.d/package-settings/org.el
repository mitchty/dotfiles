;;-*-mode: emacs-lisp; coding: utf-8;-*-

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-cp" 'org-latex-export-to-pdf)

(setq org-log-done t)
