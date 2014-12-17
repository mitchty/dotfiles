;-*-mode: emacs-lisp; coding: utf-8;-*-

; Tramp mode setup
(require 'tramp)

; Make the default proxy list sane(r)
(set-default 'tramp-default-proxies-alist
  (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

; Since work sudo only allows for su with sudo.
; We add a new 'susudo' method that uses
; sudo args USER su -c 'command you wanted to run'
; instead of sudo command
; gay but pci "security" can be pretty dumb
(add-to-list 'tramp-methods
             '("susudo"
               (tramp-login-program "sudo")
               (tramp-login-args
                (("-u" "%u")
                 ("-H")
                 ("-p" "Password:")
                 ("su -c /bin/sh")))
               (tramp-remote-sh "/bin/sh")
               (tramp-copy-program nil)
               (tramp-copy-args nil)
               (tramp-copy-keep-date nil)
               (tramp-password-end-of-line nil)))
