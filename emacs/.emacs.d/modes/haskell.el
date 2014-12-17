;;-*-mode: emacs-lisp; coding: utf-8;-*-
(custom-set-variables
 '(haskell-process-type 'ghci)
 '(haskell-process-args-ghci '())
 '(haskell-notify-p t)
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-reload-with-fbytecode nil)
 '(haskell-process-use-presentation-mode t)
 '(haskell-interactive-mode-include-file-name nil)
 '(haskell-interactive-mode-eval-pretty nil)
;; '(shm-use-hdevtools t)
;; '(shm-use-presentation-mode t)
;; '(shm-auto-insert-skeletons t)
;; '(shm-auto-insert-bangs t)
 '(haskell-process-show-debug-tips nil)
 '(haskell-process-suggest-hoogle-imports nil)
 '(haskell-process-suggest-haskell-docs-imports t))

(setq haskell-complete-module-preferred
      '("Data.ByteString"
        "Data.ByteString.Lazy"
        "Data.Function"
        "Data.List"
        "Data.Map"
        "Data.Maybe"
        "Data.Monoid"
        "Data.Ord"))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(add-hook
 'haskell-mode-hook
 '(lambda ()
    (ghc-init)
    (setq haskell-interactive-mode-eval-mode 'haskell-mode)
    '(turn-on-haskell-indentation)
    (interactive-haskell-mode)
    (custom-set-variables
     '(haskell-process-suggest-remove-import-lines t)
     '(haskell-process-auto-import-loaded-modules t)
     '(haskell-process-log t)
     '(haskell-tags-on-save t)
     '(haskell-process-type 'cabal-repl)
     )
    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
    (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
    (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
    (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
    (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
    (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
    (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
    (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)
    (define-key haskell-mode-map [f8] 'haskell-navigate-imports)
    )
 )

(add-hook 'cabal-mode-hook (lambda ()
  (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-ode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
;;    (stylish-haskell-mode)
;;    (define-key haskell-mode-map
;;      (kbd "C-x C-s") 'haskell-mode-save-buffer)
;;    (add-to-list 'align-rules-list
;;                 '(haskell-types
;;                   (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode))))
;;    (add-to-list 'align-rules-list
;;                 '(haskell-assignment
;;                   (regexp . "\\(\\s-+\\)=\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode))))
;;    (add-to-list 'align-rules-list
;;                 '(haskell-arrows
;;                   (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode))))
;;    (add-to-list 'align-rules-list
;;                 '(haskell-left-arrows
;;                   (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode))))
;;    ))

;; MOVE ME
(global-set-key (kbd "C-x a r") 'align-regexp)
