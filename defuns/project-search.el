;; has a dependency on textmate minor mode since
;; we use textmate-project-root
(defun project-search (keyword)
  "search a project"
  (interactive "sSearch Project: ")
  (grep-compute-defaults)
  (rgrep keyword "*" (textmate-project-root)))
