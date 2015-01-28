;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq scroll-conservatively 10000)

(provide 'sane-defaults)
