;;; rhtml mode
(add-to-list 'load-path "~/.emacs.d/rhtml")
  (require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.eco$" . rhtml-mode))

(provide 'setup-rhtml-mode)
