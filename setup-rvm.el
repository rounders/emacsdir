(rvm-use-default);;

(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))


(provide 'setup-rvm)
