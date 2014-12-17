;;-*-mode: emacs-lisp; coding: utf-8;-*-
(require 'package)
(setq my-packages
      '(
				helm
        dash
        s
        string-utils
        list-utils
        flycheck
        expand-region
        auto-complete
        auto-complete-clang-async
        magit
        smex
        column-marker
        ruby-end
        multi-term
        dropdown-list
        popup
        org-plus-contrib
        org-bullets
        org-pomodoro
        org-present
        color-theme
        perl-completion
        workgroups
        yasnippet
        figlet
        org-readme
        move-text
        smartparens
        markdown-mode
        yaml-mode
        go-mode
        rust-mode
        haskell-mode
				color-theme-solarized
        ))

(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

;; TODO: maybe set an ENV var to force refresh at startup?
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (pkg my-packages)
  (when (and (not (package-installed-p pkg))
           (assoc pkg package-archive-contents))
    (package-install pkg)))

(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `my-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x my-packages))
                            (not (package-built-in-p x))
                            (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))
