(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")
;;(load-theme 'manoj-dark)
(load-theme 'pastels-on-dark t)


;;(enable-theme 'tron)

;; ========== Enable Line and Column Numbering ==========

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

(set-frame-font "Menlo-16")


(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")                                                                                       
(require 'textmate)                                                                                                                            
(add-to-list 'load-path "~/.emacs.d/vendor/")                                                                                                  
(require 'peepopen)                                                                                                                            
(textmate-mode)   
(setq ns-pop-up-frames nil)

;; if you want line number down the left
;;(add-hook 'abg-code-modes-hook
;;          (lambda () (linum-mode 1)))

;;(add-hook 'ruby-mode-hook
;;          (lambda () (run-hooks 'abg-code-modes-hook)))
