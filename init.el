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

(setq scroll-conservatively 10000)

(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate) 

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

(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'peepopen)
(textmate-mode)
(setq ns-pop-up-frames nil)
(define-key rspec-mode-keymap (kbd "s") 'rspec-verify-single)


(defun shell-command-on-buffer-file ()
 "prompts for a command and executes that command on to the associated 
 file of current buffer. if no buffer is associated gives an error"
  (interactive)
  (or (buffer-file-name) (error "no file is associated file to this buffer"))
  (let* ((my-cmd (read-shell-command "Command to run: "))
         (cmd-to-run (concat my-cmd " " (buffer-file-name))))
   (shell-command cmd-to-run)))



(setq el-get-sources
      '((:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode)))
(el-get 'sync)

(if (window-system)
  (set-frame-width (selected-frame) 120))

(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "M-s-“") 'indent-region)

;; put any machine-local configuration into local/local.el
(add-to-list 'load-path "~/.emacs.d/local")
(load "local")

(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
