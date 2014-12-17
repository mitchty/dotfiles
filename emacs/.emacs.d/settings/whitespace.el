;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; Setup whitespace mode to highlight tabs and over 80 char spaces
(require 'whitespace)

(setq whitespace-style '(face tabs trailing))

(set-face-attribute 'whitespace-tab nil
                    :foreground "#2075c7"
                    :background "lightgrey")

(set-face-attribute 'whitespace-line nil
                    :foreground "#2075c7"
                    :background "lightgrey")
