;; will look for a folder called .emacs in the project root
;; and load all files found in that folder
;; This is useful for project specific settings/defuns/etc

(when (textmate-project-root)
  (setq project-dir (expand-file-name ".emacs" (textmate-project-root)))
  (when (file-exists-p project-dir)
    (dolist (file (directory-files project-dir t "\\w+"))
      (when (file-regular-p file)
        (load file)))))

(provide 'setup-project-specific-configuration)
