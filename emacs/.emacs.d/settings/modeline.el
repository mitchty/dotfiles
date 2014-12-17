;;-*-mode: emacs-lisp; coding: utf-8;-*-

(custom-set-variables '(mode-line-format
      (list
       '(:eval (propertize "%b " 'face 'font-lock-keyword-face
                           'help-echo (buffer-file-name)))
       (propertize "%02l" 'face 'font-lock-type-face) ","
       (propertize "%02c" 'face 'font-lock-type-face)
       " ["
       '(:eval (propertize "%m" 'face 'font-lock-string-face
                           'help-echo buffer-file-coding-system))
       minor-mode-alist
       "] "
       "["
       '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
                           'face 'font-lock-preprocessor-face
                           'help-echo (concat "Buffer is in "
                                              (if overwrite-mode "overwrite" "insert") " mode")))
       '(:eval (when (buffer-modified-p)
                 (concat ","  (propertize "Mod"
                                          'face 'font-lock-warning-face
                                          'help-echo "Buffer has been modified"))))
       '(:eval (when buffer-read-only
                 (concat ","  (propertize "RO"
                                          'face 'font-lock-type-face
                                          'help-echo "Buffer is read-only"))))        "] "
       '(:eval (propertize (format-time-string "%H:%M:%S")
                           'help-echo
                           (concat (format-time-string "%c; ")
                                   (emacs-uptime "Uptime:%hh"))))
       " --"
       "%-"
       )))
