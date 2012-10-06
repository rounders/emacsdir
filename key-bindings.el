(global-set-key (kbd "C-c n") 'nav)

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

;; key bindings for mark-more-like-this
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this)
(global-set-key (kbd "C-*") 'mark-all-like-this)

;; key bindings for inline-string-rectangle
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

;;
(define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)

(provide 'key-bindings)
