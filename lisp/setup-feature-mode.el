(require 'feature-mode)

(setq feature-cucumber-command "bundle exec rake cucumber CUCUMBER_OPTS=\"{options}\" FEATURE=\"{feature}\" RAILS_ENV=test")
(setq feature-use-rvm t)
(provide 'setup-feature-mode)
