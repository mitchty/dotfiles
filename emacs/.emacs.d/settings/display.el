;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; if I selected it, deleting it is OK kthxbai
(delete-selection-mode 1)

;; be more like vi, display line/col always
(custom-set-variables '(line-number-mode t))
(custom-set-variables '(column-number-mode t))

;; 80 char lines not 72
(custom-set-variables '(fill-column 80))

;; ok, double spacing after a period for sentences
;; is fucking archaic, we don't use typewriters any longer
(set-default 'sentence-end-double-space nil)

;; What emacs thinks a sentence ending is, make it less derp.
(custom-set-variables '(sentence-end "[.?!][]\"')]*\\($\\|\t\\| \\)[ \t\n]*"))
(custom-set-variables '(sentence-end-double-space nil))

;; Tabs suck, no
(custom-set-variables '(default-tab-width 2))

;; Always remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
