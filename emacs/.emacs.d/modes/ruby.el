;;-*-mode: emacs-lisp; coding: utf-8;-*-

(autoload 'ruby-mode "ruby-mode" "mode for Ruby formatted stuff" t)

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (load "mode-defaults")
             (smartparens-mode)
             (ruby-end-mode)
             (flycheck-mode)
             ))
