;; functions that I'm unsure about
;; start their lives here.

;; http://stackoverflow.com/questions/3417438/closing-all-other-buffers-in-emacs
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun mojo (arg)
  "mojo line ARG, counting from line 1 at beginning of buffer"
  (interactive "Nmojo line: ")
  (save-restriction
    (widen)
    (goto-char 1)
    (forward-line (1- arg))))

(defun insert-html-tag ()
  "insert html tag with matching closing tag"
  (interactive)
  (let (p1 p2 tag)
    (setq tagBoundaries (bounds-of-thing-at-point 'word))
    (setq p1 (car tagBoundaries))
    (setq p2 (cdr tagBoundaries))
    (setq tag (buffer-substring p1 p2))
    (delete-region p1 p2)
    (insert (concat "<" tag "></" tag ">"))
    (backward-char (+ (length tag) 3))))
