;; 選択した単語をそのまま検索できるようにする
(require 'helm)
(require 'helm-config)

(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
