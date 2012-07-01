(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))


;; Set up load path
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; ensure my favourite packages are installed and required
(require 'packages)

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" dotfiles-dir))
(load custom-file)

;; Write backup files to own directory
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(require 'setup-rvm)
(require 'setup-textmate-mode)
(require 'setup-ruby-mode)
(require 'setup-rspec-mode)
(require 'setup-rhtml-mode)
(require 'appearance)
(require 'sane-defaults)
(require 'setup-coffee-mode)
(require 'setup-keychords)
(require 'setup-yasnippet)
(require 'setup-autocomplete)
(require 'setup-css-and-scss-mode)
(require 'setup-handlebars-mode)
(require 'setup-markdown-mode)
(require 'setup-feature-mode)
(require 'setup-ido-mode)
(require 'setup-linum-mode)
(require 'mark-more-like-this)
(require 'inline-string-rectangle)
(require 'rename-sgml-tag)
(require 'key-bindings)
(when is-mac (require 'setup-peepopen))

;; for easy navigation between windows
(windmove-default-keybindings)


;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" dotfiles-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))
