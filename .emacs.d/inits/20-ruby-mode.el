;; RakefileとGemfileもruby-modeで開く
(add-to-list 'auto-mode-alist '("[Rr]akefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; # coding: utf-8 は不要
(setq ruby-insert-encoding-magic-comment nil)
