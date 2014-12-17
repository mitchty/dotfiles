;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; flymake is old, lets use something better.
(setq flycheck-indication-mode 'right-fringe)

;; Test out grizzl for completions.
;;(setq flycheck-select-checker 'grizzl)

;; Make flycheck able to parse CFLAGS from pkg-config
(defun pkg-config-add-lib-cflags (pkg-config-lib)
  "This function will add necessary header file path of a
specified by `pkg-config-lib' to `flycheck-clang-include-path', which make it
completionable by auto-complete-clang"
  (interactive "spkg-config lib: ")
  (if (executable-find "pkg-config")
      (if (= (shell-command
              (format "pkg-config %s" pkg-config-lib))
             0)
          (setq flycheck-clang-include-path
                (append flycheck-clang-include-path
                        (split-string
                         (shell-command-to-string
                          (format "pkg-config --cflags-only-I %s"
                                  pkg-config-lib)))))
        (message "Error, pkg-config lib %s not found." pkg-config-lib))
    (message "Error: pkg-config tool not found.")))
