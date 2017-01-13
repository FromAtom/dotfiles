;; company-modeの初期設定

(global-company-mode)

;; 色周り
(set-face-attribute 'company-tooltip nil
                    :foreground "#002B36"
                    :background "#93A1A1"
                    )
(set-face-attribute 'company-preview-common nil
                    :foreground "orange"
                    :background "white"
                    :underline t)
(set-face-attribute 'company-tooltip-selection nil
                    :background "#FDF6E3"
                    :foreground "#002B36")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "#002B36"
                    :background "#93A1A1"
                    :underline t)
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white"
                    :background "steelblue"
                    :underline t)
(set-face-attribute 'company-tooltip-annotation nil
                    :foreground "#D33682"
                    :background "#93A1A1")
(set-face-attribute 'company-tooltip-annotation-selection nil
                    :foreground "#D33682" ; "#FDF6E3"
                    :background "#FDF6E3")

(setq company-tooltip-align-annotations t)

;; 挙動周り
(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 1)
