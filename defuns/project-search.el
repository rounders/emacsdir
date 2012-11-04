(require 'find-dired)

;; has a dependency on textmate minor mode since
;; we use textmate-project-root
(defun project-search (keyword)
  "search a project"
  (interactive "sSearch Project: ")
  (grep-compute-defaults)
  (rgrep keyword "*" (textmate-project-root)))

;; the stuff below is a work-in-progress and does
;; work as intended
(defun ignore-directories-options-for-find ()
  (concat "-type d "
          (shell-quote-argument "(")
          ;; we should use shell-quote-argument here
          " -path "
          (mapconcat
           #'(lambda (ignore)
               (cond ((stringp ignore)
                      (shell-quote-argument
                       (concat "*/" ignore)))
                     ((consp ignore)
                      (and (funcall (car ignore) dir)
                           (shell-quote-argument
                            (concat "*/"
                                    (cdr ignore)))))))
           grep-find-ignored-directories
           " -o -path ")
          " "
          (shell-quote-argument ")")
          " -prune -o "))

(defun my-find-grep-command (regexp)
  (concat "find . "
                     (shell-quote-argument "(")
                     " "
                     (ignore-directories-options-for-find)
                     " -type f -exec grep -I -q -e "
                     regexp
                     " "
                     (shell-quote-argument "{}")
                     " "
                     (shell-quote-argument ";")
                     " -ls "
                     (shell-quote-argument ")")

                     ))

(defun my-find-grep-dired (dir regexp)
  "Find files in dir containing a regexp and start Dired on output"
  (interactive "DFind-grep (directory): \nsFind-grep (grep regexp): ")

  (setq command (my-find-grep-command regexp))
  (let ((dired-buffers dired-buffers))
    ;; Expand DIR ("" means default-directory), and make sure it has a
    ;; trailing slash.
    (setq dir (file-name-as-directory (expand-file-name dir)))
    ;; Check that it's really a directory.
    (or (file-directory-p dir)
	(error "find-dired needs a directory: %s" dir))
    (switch-to-buffer (get-buffer-create "*Find*"))

    ;; See if there's still a `find' running, and offer to kill
    ;; it first, if it is.
    (let ((find (get-buffer-process (current-buffer))))
      (when find
	(if (or (not (eq (process-status find) 'run))
		(yes-or-no-p "A `find' process is running; kill it? "))
	    (condition-case nil
		(progn
		  (interrupt-process find)
		  (sit-for 1)
		  (delete-process find))
	      (error nil))
	  (error "Cannot have two processes in `%s' at once" (buffer-name)))))

    (widen)
    (kill-all-local-variables)
    (setq buffer-read-only nil)
    (erase-buffer)
    (setq default-directory dir)
    ;; Start the find process.
    (shell-command (concat command "&") (current-buffer))
    ;; The next statement will bomb in classic dired (no optional arg allowed)
    (dired-mode dir (cdr find-ls-option))
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map (current-local-map))
      (define-key map "\C-c\C-k" 'kill-find)
      (use-local-map map))
    (make-local-variable 'dired-sort-inhibit)
    (setq dired-sort-inhibit t)
    (set (make-local-variable 'revert-buffer-function)
	 `(lambda (ignore-auto noconfirm)
	    (my-find-grep-dired ,dir ,regexp)))
    ;; Set subdir-alist so that Tree Dired will work:
    (if (fboundp 'dired-simple-subdir-alist)
	;; will work even with nested dired format (dired-nstd.el,v 1.15
	;; and later)
	(dired-simple-subdir-alist)
      ;; else we have an ancient tree dired (or classic dired, where
      ;; this does no harm)
      (set (make-local-variable 'dired-subdir-alist)
	   (list (cons default-directory (point-min-marker)))))
    (set (make-local-variable 'dired-subdir-switches) find-ls-subdir-switches)
    (setq buffer-read-only nil)
    ;; Subdir headlerline must come first because the first marker in
    ;; subdir-alist points there.
    (insert "  " dir ":\n")
    ;; Make second line a ``find'' line in analogy to the ``total'' or
    ;; ``wildcard'' line.
    (insert "  " command "\n")
    (setq buffer-read-only t)
    (let ((proc (get-buffer-process (current-buffer))))
      (set-process-filter proc (function find-dired-filter))
      (set-process-sentinel proc (function find-dired-sentinel))
      ;; Initialize the process marker; it is used by the filter.
      (move-marker (process-mark proc) 1 (current-buffer)))
    (setq mode-line-process '(":%s"))))
