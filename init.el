# provide access to marmalade package management
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")
;;(load-theme 'manoj-dark)
;;(load-theme 'pastels-on-dark t)


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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (pastels-on-dark)))
 '(custom-safe-themes (quote ("30fe7e72186c728bd7c3e1b8d67bc10b846119c45a0f35c972ed427c45bacc19" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq el-get-sources
      '((:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode)))
(el-get 'sync)

(if (window-system)
  (set-frame-width (selected-frame) 120))

