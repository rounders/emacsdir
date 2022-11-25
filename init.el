(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))
(setq lisp-dir (expand-file-name "lisp" dotfiles-dir))

(setq dropbox-notes-path "~/Dropbox/notes")
(setq todo-file-on-dropbox "~/Dropbox/notes/todo.org")

(tool-bar-mode -1)

;; Set up load path
(add-to-list 'load-path lisp-dir)
(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; ensure my favourite packages are installed and required
(require 'packages)

;; places where custom themes might be living
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")


;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" lisp-dir))
(load custom-file)

;; Write backup files to own directory
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; disable lockfiles
(setq create-lockfiles nil)

 (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(require 'appearance)
(require 'setup-rvm)
(require 'setup-textmate-mode)
(require 'setup-ruby-mode)
(require 'setup-rspec-mode)
;;(require 'setup-rhtml-mode)
(require 'setup-slim-mode)
(require 'sane-defaults)
(require 'setup-coffee-mode)
(require 'setup-javascript-mode)
(require 'setup-keychords)
(require 'setup-yasnippet)
(require 'setup-autocomplete)
(require 'setup-css-and-scss-mode)
(require 'setup-web-mode)
(require 'setup-markdown-mode)
(require 'setup-feature-mode)
(require 'setup-ido-mode)
(require 'setup-linum-mode)
(require 'multiple-cursors)
(require 'key-bindings)
(require 'setup-rgrep)
(require 'setup-yaml-mode)
(require 'setup-rcodetools)
(require 'setup-ag)
(require 'setup-project-specific-configuration)
(require 'helm-config)
(require 'setup-projectile)

;; disable visual bell
;; see https://www.reddit.com/r/emacs/comments/3omsr2/weird_display_issue_in_os_x/
(setq ring-bell-function (lambda () (message "*woop*")))

;; ffap tries to ping something that looks like domain when trying to
;; open files - turn that off
(setq ffap-machine-p-known 'reject)

;; for easy navigation between windows
(windmove-default-keybindings)


;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" dotfiles-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; disable autofill-mode
(auto-fill-mode -1)
(remove-hook 'text-mode-hook 'turn-on-auto-fill)
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(setq shell-file-name "/bin/bash")

;; This works for copying, but not pasting for some reason
(setq select-enable-clipboard t)

;; Whatever... it's easy enough to implement that part ourselves
(setq interprogram-paste-function
      (lambda ()
        (shell-command-to-string "pbpaste")))
