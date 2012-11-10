(defun annotate-ruby()
  "do it up"
  (interactive)
  (progn
    (move-end-of-line nil)
    (insert "  # => ")
    (xmp)
    (forward-char)))
