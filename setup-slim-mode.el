(add-to-list 'load-path "~/emacs.d/vendor")

(require 'slim-mode)

(add-hook 'slim-mode-hook
  (lambda ()
    (setq slim-indent-offset 2)
    (setq slim-indent-function `slim-bunk)
    (setq indent-tabs-mode f)))


(defun slim-bunk ()                                                                                "Returns true if the current line can have lines nested beneath it."                                  (loop for opener in slim-block-openers                                                                      if (looking-at opener) return t                                                                       finally return t))


(provide 'setup-slim-mode)
