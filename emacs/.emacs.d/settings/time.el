;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; I only want the time in my modeline, not system load
;; %T is HH:MM:SS basically
;; Also update every 5 seconds instead of 60
(custom-set-variables '(display-time-default-load-average nil))
(custom-set-variables '(display-time-format "%T"))
(custom-set-variables '(display-time-interval 5))

;; Set the time in the mode line
(display-time-mode)
