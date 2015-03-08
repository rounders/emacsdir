(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-indexing-method 'alien)


(require 'helm-projectile)
(helm-projectile-on)

(provide 'setup-projectile)
