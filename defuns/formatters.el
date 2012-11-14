;; will format entire buffer using the python json.tool
(defun format-json()
  "make json pretty"
  (interactive)
  (progn
    (mark-whole-buffer)
    (shell-command-on-region
     (point-min)
     (point-max)
     "python -m json.tool"
     (current-buffer)
     t)))

;; TODO: write format-json-on-region()
