;;-*-mode: emacs-lisp; coding: utf-8;-*-
;; Shamelesly copied from https://github.com/correl/dotfiles
;; Bootstrap us into being able to use org for the initialization file.
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; Install use-package for later use and to install org mode.
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)
    (package-initialize)))

(require 'use-package)

;; Somewhat needed so we can use org to manage things.
(use-package org
	     :ensure org-plus-contrib)

(require 'org)
(org-babel-load-file "~/.emacs.d/init.org")
