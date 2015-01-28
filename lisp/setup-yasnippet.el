(require 'yasnippet)


;; Develop and keep personal snippets under ~/emacs.d/mysnippets
;;(setq yas/root-directory "~/.emacs.d/elpa/yasnippet-0.6.1/snippets/")
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"            ;; personal snippets
        "~/.emacs.d/elpa/yasnippet-0.8.0/snippets/" ;; the default collection
        ))

(yas/global-mode 1)

;; Load the snippets
;;(yas/load-directory yas/root-directory)

(provide 'setup-yasnippet)
