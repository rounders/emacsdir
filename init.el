;; provide access to marmalade package management
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

(require 'rvm)
(rvm-use-default);;

(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

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


(setq el-get-sources
      '((:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode)))
(el-get 'sync)

(if (window-system)
  (set-frame-width (selected-frame) 120))

(global-set-key (kbd "C-x C-g") 'magit-status)

;; put any machine-local configuration into local/local.el
(add-to-list 'load-path "~/.emacs.d/local")
(load "local")

(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


