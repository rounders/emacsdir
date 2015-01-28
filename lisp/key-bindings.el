(global-set-key (kbd "C-c n") 'nav)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key (kbd "C-x C-f") 'textmate-goto-file)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C-x C-g") 'magit-status)

(global-set-key (kbd "M-s-“") 'indent-region)

(define-key global-map (kbd "C-c C-p") 'ag-project-regexp)

(define-key rspec-mode-keymap (kbd "s") 'rspec-verify-single)

(add-hook 'ruby-mode-hook
     (lambda () (define-key ruby-mode-map (kbd "C-i") 'indent-for-tab-command)))

(add-hook 'ruby-mode-hook
          '(lambda () (define-key ruby-mode-map (kbd "C-x >") 'annotate-ruby)))


(add-hook 'textmate-mode-hook
 (lambda ()
   (define-key global-map (kbd "C-i") 'indent-for-tab-command)
))

;; key bindings for multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; bindings for changing font sizes
;; uses custom defun in defuns/font-size.el
(global-set-key (kbd "s-+") 'increase-font-size)
(global-set-key (kbd "s--") 'decrease-font-size)
(global-set-key (kbd "s-_") 'decrease-font-size)

;; binding for next-error and prev-error because
;; I can't remember M-g n and M-g p
(global-set-key (kbd "s->") `next-error)
(global-set-key (kbd "s-<") 'previous-error)



(provide 'key-bindings)
