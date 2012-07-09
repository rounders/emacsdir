
(defun load-todo ()
  "loads my org-mode todo from my dropbox folder"
  (interactive)
  (split-window-vertically)
  (find-file todo-file-on-dropbox))
