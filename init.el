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

(global-set-key (kbd "C-c C-n") 'nav)

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

(add-hook 'textmate-mode-hook
 (lambda ()
   (define-key global-map (kbd "C-i") 'indent-for-tab-command)
))

(add-hook 'ruby-mode-hook
     (lambda () (define-key ruby-mode-map (kbd "C-i") 'indent-for-tab-command)))

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

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 200))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

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



(global-set-key (kbd "C-x C-f") 'textmate-goto-file)

(require 'coffee-mode)
(defun coffee-custom ()
  "coffee-mode-hook"

  ;; CoffeeScript uses two spaces.
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'coffee-custom)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "FF"     'find-file)

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
