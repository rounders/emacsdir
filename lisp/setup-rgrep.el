(require 'grep)
;; -- https://groups.google.com/forum/?fromgroups=#!topic/emacs-on-rails/Y-TX-RYgY3Y
(add-to-list 'grep-files-aliases (cons "rails" "*.rb *.erb *.js *.css *.sass *.rake"))

(provide 'setup-rgrep)
