;; 補完
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-to-list 'company-backends 'company-sourcekit)
