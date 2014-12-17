;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; use incremental complete mode for the minibuffer
(icomplete-mode)

;; highlight parens n stuff
(show-paren-mode)

;; y/n is good enough
(defalias 'yes-or-no-p 'y-or-n-p)

;; Default major mode is just text
(custom-set-variables '(default-major-mode 'text-mode))

;; Don't clobber minibuffer text
(custom-set-variables '(help-at-pt-timer-delay 0.9))

;; Auto chmod u+x on scripts, because why wouldn't you?
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Ok backup files are annoying
(setq make-backup-files nil)
(setq auto-save-default nil)

;; What to do with backup crap/autosave files
(setq backup-by-copying t)
(setq backup-directory-alist
      `((".*" . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))
