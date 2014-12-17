;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; Load/setup mode hook file(s) in ~/modes
(mapcar 'load-file (directory-files "~/.emacs.d/modes" t ".*.el$"))
