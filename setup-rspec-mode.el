(add-to-list 'load-path "~/.emacs.d/vendor/rspec-mode")
(require 'rspec-mode)

(setq rspec-spec-command "rspec")
;; (setq rspec-use-rvm t)
(setq rspec-use-rake-flag nil)

(define-key rspec-mode-verifible-keymap (kbd "s") 'rspec-verify-single)

(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))
(ad-activate 'rspec-compile)


(provide 'setup-rspec-mode)
