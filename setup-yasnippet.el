(require 'yasnippet)
(yas/global-mode 1)

;; Develop and keep personal snippets under ~/emacs.d/mysnippets
(setq yas/root-directory "~/.emacs.d/elpa/yasnippet-0.6.1/snippets/")

;; Load the snippets
(yas/load-directory yas/root-directory)

(provide 'setup-yasnippet)
