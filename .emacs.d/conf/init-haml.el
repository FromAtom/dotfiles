(require 'haml-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-hook 'haml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (define-key haml-mode-map "\C-m" 'newline-and-indent)))

(require 'highlight-indentation)
(setq highlight-indentation-offset 2)
(set-face-background 'highlight-indentation-face "#808080")
(set-face-background 'highlight-indentation-current-column-face "#606060")

(add-hook 'coffee-mode-hook 'highlight-indentation-current-column-mode)
(add-hook 'cperl-mode-hook  'highlight-indentation-current-column-mode)
(add-hook 'scss-mode-hook   'highlight-indentation-current-column-mode)
(add-hook 'haml-mode-hook   'highlight-indentation-current-column-mode)
