;;-*-mode: emacs-lisp; coding: utf-8;-*-
;; In case I screw up something later, debug stuff
(setq debug-on-error t)

;; Simplify os detection a skosh
(defvar mswindows-p (string-match "windows" (symbol-name system-type))
  "Am I running under windows?")
(defvar osx-p (string-match "darwin" (symbol-name system-type))
  "Am I running under osx?")
(defvar linux-p (string-match "gnu/linux" (symbol-name system-type))
  "Am I running under linux?")

;; Yes, I miss perl chomp, sue me
(defun chomp (str)
  "Chomp leading and trailing whitespace from STR."
  (let ((s (if (symbolp str) (symbol-name str) str)))
  (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" s)))

;; I'm not about to redo logic to setup PATH in emacs that I have in
;; .profile/.*shrc crap.
;; So, just use whatever PATH had when we were run.
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
	 (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; This is really only needed when the gui emacs runs.
(if osx-p
		(set-exec-path-from-shell-PATH)
	)

;; Base directory
(defvar load-base "~/.emacs.d" "Where the emacs directory is kept")

;; Bootstrap load path
(add-to-list 'load-path load-base)

;; Temp file dir (unixes)
(setq temporary-file-directory "/tmp")

;; Set the default temp file dir for the current user based off username
(defvar user-temporary-file-directory
  (format "%s/%s" temporary-file-directory user-login-name))

;; mkdir for temporary-file-directory if needed
(unless (file-accessible-directory-p user-temporary-file-directory)
  (make-directory user-temporary-file-directory t))

;; Load up settings of things, in no particular order or anything
(mapcar 'load-file (directory-files "~/.emacs.d/settings/" t ".*.el$"))

;; Setup/install third party packages using builtin package manager.
(load "emacs-package")

;; Load up settings for things that el-get installed
(mapcar 'load-file (directory-files "~/.emacs.d/package-settings/" t ".*.el$"))

;; Cleanup startup buffers
(add-hook 'after-init-hook
          '(lambda () (load "after-init")))

;; Fine, emacsclient -c and emacs --daemon don't mix well
;; From now on I start emacs as a gui and have this startup the daemon
(load "server")
(unless (server-running-p) (server-start))
