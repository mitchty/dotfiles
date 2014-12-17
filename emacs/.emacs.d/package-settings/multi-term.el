;;-*-mode: emacs-lisp; coding: utf-8;-*-

;; multi-term only on non-windows, stupid windows command line
(unless mswindows-p
  ;; multi-term setup
  (autoload 'multi-term "multi-term" nil t)
  (autoload 'multi-term-next "multi-term" nil t)

  ;; fuck you audible beeps
  (setq ring-bell-function (lambda () (message "*beep beep imma jeep*")))

  ;; try and use zsh when we can, cause bourne/bourne-again are the suck
  (setq multi-term-program (cond
                            ((file-exists-p "/bin/zsh") "/bin/zsh")
                            ((file-exists-p "/usr/bin/zsh") "/usr/bin/zsh")
                            ((t) "/bin/sh");; fine use whatever the hell /bin/sh is
                            ))

  ;; allow switching to the next terminal in line
  (global-set-key (kbd "C-c C-t") 'multi-term-next)

  ;; zomg annoying, term-unbind-key-list is what it unbinds, not what you want
  ;; to unbind. bit of a logic weirdout in my mind.
  ;; aka, what is in the term-unbind-key-list is what you can type to the terminal
  (setq term-unbind-key-list '("C-x" "C-y" "M-x"))
  )
