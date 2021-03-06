;;; el-get --- Manage the external elisp bits and pieces you depend upon
;;
;; Copyright (C) 2010-2011 Dimitri Fontaine
;;
;; Author: Dimitri Fontaine <dim@tapoueh.org>
;; URL: http://www.emacswiki.org/emacs/el-get
;; GIT: https://github.com/dimitri/el-get
;; Licence: WTFPL, grab your copy here: http://sam.zoy.org/wtfpl/
;;
;; This file is NOT part of GNU Emacs.
;;
;; Install
;;     Please see the README.asciidoc file from the same distribution

(require 'el-get-http)

(defcustom el-get-emacswiki-base-url
  "http://www.emacswiki.org/emacs/download/"
  "The base URL where to fetch :emacswiki packages"
  :group 'el-get
  :type 'string)

(defcustom el-get-emacswiki-elisp-file-list-url
  "http://www.emacswiki.org/cgi-bin/wiki?action=elisp"
  "The emacswiki URL where to fetch a list of elisp files with descriptions.

We get back list of filename space first line, and in general
that matches the following pattern:

filename.el ;;; filename.el --- description"
  :group 'el-get
  :type 'string)

(defun el-get-emacswiki-install (package url post-install-fun)
  "Download a single-file PACKAGE over HTTP from emacswiki."
  (let ((url (or url (format "%s%s.el" el-get-emacswiki-base-url package))))
    (el-get-http-install package url post-install-fun)))

(el-get-register-derived-method :emacswiki :http
  :install #'el-get-emacswiki-install
  :update #'el-get-emacswiki-install)

;;;
;;; Functions to maintain a local recipe list from EmacsWiki
;;;
(defun el-get-emacswiki-retrieve-package-list ()
  "return a list of (URL PACKAGE DESCRIPTION) from emacswiki"
  (loop for line in
	(split-string
	 (with-current-buffer
	     (url-retrieve-synchronously el-get-emacswiki-elisp-file-list-url)
	   ;; prune HTTP headers
	   (goto-char (point-min))
	   (re-search-forward "^$" nil 'move)
	   (forward-char)
	   (delete-region (point-min) (point))
	   (buffer-string))
	 "\n")
	for filename = (substring line 0 (string-match " " line))
	for description = (if (string-match "--?-? " line)
			      (substring line (match-end 0)) "")
	for url = (format "%s%s" el-get-emacswiki-base-url filename)
	collect (list url filename description)))

(defun el-get-emacswiki-build-local-recipes (&optional target-dir)
  "retrieve the index of elisp pages at emacswiki and turn them
into a local recipe file set"
  (let ((target-dir (or target-dir
			(car command-line-args-left)
			el-get-recipe-path-emacswiki))
	(coding-system-for-write 'utf-8))
    (unless (file-directory-p target-dir) (make-directory target-dir))
    (loop
     for (url package description) in (el-get-emacswiki-retrieve-package-list)
     for recipe = (replace-regexp-in-string "el$" "rcp" package)
     for rfile  = (expand-file-name recipe target-dir)
     unless (file-exists-p rfile)
     do (with-temp-file (expand-file-name rfile target-dir)
	  (message "%s: %s" package description)
	  (insert
	   (format
	    "(:name %s\n:type emacswiki\n:description \"%s\"\n:website \"%s\")"
	    (file-name-sans-extension package) description url))
	  ;; (encode-coding-region (point-min) (point-max) 'utf-8)
	  (indent-region (point-min) (point-max))))))

;;;###autoload
(defun el-get-emacswiki-refresh (&optional target-dir)
  "run Emacs -Q in an asynchronous subprocess to get the package
list from emacswiki and build a local recipe directory out of
that"
  (interactive
   (list (let ((dummy (unless (file-directory-p el-get-recipe-path-emacswiki)
			(make-directory el-get-recipe-path-emacswiki))))
	   (read-directory-name "emacswiki recipes go to: "
				el-get-recipe-path-emacswiki))))
  (let* ((name "*el-get-emacswiki*")
	 (dummy (when (get-buffer name) (kill-buffer name)))
	 (args
	  (format
	   "-Q -batch -L %s -L %s -l %s -f el-get-emacswiki-build-local-recipes %s"
	   (el-get-package-directory 'el-get)
	   (expand-file-name "methods" (el-get-package-directory 'el-get))
	   (file-name-sans-extension
	    (symbol-file 'el-get-emacswiki-build-local-recipes 'defun))
	   target-dir))
	 (process
	  (apply 'start-process name name el-get-emacs (split-string args))))
    (message "%s %s" el-get-emacs args)
    (set-process-sentinel
     process
     '(lambda (proc event)
	(when (eq (process-status proc) 'exit)
	  (el-get-notify "el-get: EmacsWiki"
			 "EmacsWiki local recipe list refreshed"))))))

(provide 'el-get-emacswiki)
