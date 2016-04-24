;;-*-mode: emacs-lisp; coding: utf-8;-*-
;; File: tangle.el

;; Load the default options used or what was passed in as OPTIONS
(defun load-defaults-or-options ()
    (load-file (if (getenv "OPTIONS")
                   (concat (concat "./" (getenv "OPTIONS")) ".el")
                 "./defaults.el")))

;; Define functions we use in :tangle blocks

;; tangle/yn
;; tangle to "yes" or "no" if the predicate given exists and defined as t.
;;
;; Iff predicate is bound, and t, "yes"
;; rest is "no"
(defun tangle/yn (p) (load-defaults-or-options) (if (bound-and-true-p p) "yes" "no"))

;; tangle/file
;; tangle to filename if predicate is bound and t
;; Note, prepends tmp/ to the filename to conform to match expected layout
(defun tangle/file (p file) (load-defaults-or-options) (if (bound-and-true-p p) (concat "tmp/" file) "no"))
