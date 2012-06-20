(global-set-key (kbd "C-c C-n") 'nav)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key (kbd "C-x C-f") 'textmate-goto-file)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C-x C-g") 'magit-status)

(global-set-key (kbd "M-s-“") 'indent-region)

(define-key rspec-mode-keymap (kbd "s") 'rspec-verify-single)

(add-hook 'ruby-mode-hook
     (lambda () (define-key ruby-mode-map (kbd "C-i") 'indent-for-tab-command)))

(add-hook 'textmate-mode-hook
 (lambda ()
   (define-key global-map (kbd "C-i") 'indent-for-tab-command)
))

(provide 'key-bindings)
