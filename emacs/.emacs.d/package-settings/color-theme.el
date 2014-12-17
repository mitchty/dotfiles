;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; use gtk-ide for my color theme, solarized has... issues.
;; aka with it setup, even from latest git source, it seems to crash
;; connections with emacsclient due to some face issue.
;; so eff it, ignore the thing. TODO: find out how/why
;; emacs segv's on linux/osx with it on, but i'm lazy prolly won't
(color-theme-initialize)

(if (or window-system osx-p)
    (color-theme-gtk-ide)
  (color-theme-hober))

(unless (or window-system osx-p)
  (color-theme-install-frame-params
   '((background-color . "white"))))

;; fixup multi-term fg/bg color support as it doesn't always
;; pickup defaults
(setq term-default-bg-color (face-background 'default))
(setq term-default-fg-color (face-foreground 'default))
