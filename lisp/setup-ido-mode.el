;; Ignore .DS_Store files with ido mode
(add-to-list 'completion-ignored-extensions ".JPG")
(add-to-list 'completion-ignored-extensions ".jpg")
(add-to-list 'completion-ignored-extensions ".DS_Store")
;; (add-to-list 'ido-ignore-files "\\.DS_Store")
;;(add-to-list 'ido-ignore-files "\\.JPG")
;;(add-to-list 'ido-ignore-files "\\.jpg")
(setq ido-auto-merge-delay-time 1)
(provide 'setup-ido-mode)
