;;-*-mode: emacs-lisp; coding: utf-8;-*-

(when window-system
	(require 'cl)

  (defun font-candidate (&rest fonts)
    "Return first font that matches list of provided fonts."
    (find-if (lambda (f) (find-font (font-spec :name f))) fonts))

  ;; Try out these fonts in order of preference depending on install status.
  (set-face-attribute 'default nil :font
                      (font-candidate '"Source Code Pro-14:weight=normal"
                                      "Menlo-12:weight=normal"
                                      "Monaco-12:weight=normal"))

	(cond (linux-p
         (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
         (setq x-select-enable-clipboard t)
				 )
				)
	)
